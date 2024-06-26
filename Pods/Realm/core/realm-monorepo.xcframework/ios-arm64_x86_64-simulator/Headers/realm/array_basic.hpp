/*************************************************************************
 *
 * Copyright 2016 Realm Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **************************************************************************/

#ifndef REALM_ARRAY_BASIC_HPP
#define REALM_ARRAY_BASIC_HPP

#include <realm/node.hpp>
#include <realm/null.hpp>
#include <realm/query_conditions.hpp>

namespace realm {

/// A BasicArray can currently only be used for simple unstructured
/// types like float, double.
template <class T>
class BasicArray : public Node, public ArrayPayload {
public:
    using value_type = T;

    explicit BasicArray(Allocator&) noexcept;
    ~BasicArray() noexcept override {}

    static T default_value(bool)
    {
        return T{};
    }

    void init_from_ref(ref_type ref) noexcept override
    {
        Node::init_from_mem(MemRef(ref, m_alloc));
    }

    void set_parent(ArrayParent* parent, size_t ndx_in_parent) noexcept override
    {
        Node::set_parent(parent, ndx_in_parent);
    }

    void init_from_parent() noexcept
    {
        ref_type ref = get_ref_from_parent();
        init_from_ref(ref);
    }

    // Disable copying, this is not allowed.
    BasicArray& operator=(const BasicArray&) = delete;
    BasicArray(const BasicArray&) = delete;

    T get(size_t ndx) const noexcept;
    bool is_null(size_t ndx) const noexcept
    {
        // FIXME: This assumes BasicArray will only ever be instantiated for float-like T.
        static_assert(realm::is_any<T, float, double>::value, "T can only be float or double");
        auto x = BasicArray<T>::get(ndx);
        return null::is_null_float(x);
    }
    void add(T value);
    void set(size_t ndx, T value);
    void insert(size_t ndx, T value);
    void erase(size_t ndx);
    void truncate(size_t size);
    void move(BasicArray& dst, size_t ndx)
    {
        for (size_t i = ndx; i < m_size; i++) {
            dst.add(get(i));
        }
        truncate(ndx);
    }
    void clear();

    size_t find_first(T value, size_t begin = 0, size_t end = npos) const;

    /// Get the specified element without the cost of constructing an
    /// array instance. If an array instance is already available, or
    /// you need to get multiple values, then this method will be
    /// slower.
    static T get(const char* header, size_t ndx) noexcept;
    Mixed get_any(size_t ndx) const override
    {
        return Mixed(get(ndx));
    }

    /// Construct a basic array of the specified size and return just
    /// the reference to the underlying memory. All elements will be
    /// initialized to `T()`.
    static MemRef create_array(size_t size, Allocator&);

    /// Create a new empty array and attach this accessor to it. This
    /// does not modify the parent reference information of this
    /// accessor.
    ///
    /// Note that the caller assumes ownership of the allocated
    /// underlying node. It is not owned by the accessor.
    void create(Node::Type = type_Normal, bool context_flag = false);

    void verify() const {}

private:
    size_t calc_byte_len(size_t count, size_t width) const override;
    virtual size_t calc_item_count(size_t bytes, size_t width) const noexcept override;

    /// Calculate the total number of bytes needed for a basic array
    /// with the specified number of elements. This includes the size
    /// of the header. The result will be upwards aligned to the
    /// closest 8-byte boundary.
    static size_t calc_aligned_byte_size(size_t size);
};

template <class T>
class BasicArrayNull : public BasicArray<T> {
public:
    using BasicArray<T>::BasicArray;

    static util::Optional<T> default_value(bool nullable)
    {
        return nullable ? util::Optional<T>() : util::Optional<T>(T{});
    }
    void set(size_t ndx, util::Optional<T> value)
    {
        if (value) {
            BasicArray<T>::set(ndx, *value);
        }
        else {
            BasicArray<T>::set(ndx, null::get_null_float<T>());
        }
    }
    void add(util::Optional<T> value)
    {
        if (value) {
            BasicArray<T>::add(*value);
        }
        else {
            BasicArray<T>::add(null::get_null_float<T>());
        }
    }
    void insert(size_t ndx, util::Optional<T> value)
    {
        if (value) {
            BasicArray<T>::insert(ndx, *value);
        }
        else {
            BasicArray<T>::insert(ndx, null::get_null_float<T>());
        }
    }

    void set_null(size_t ndx)
    {
        // FIXME: This assumes BasicArray will only ever be instantiated for float-like T.
        set(ndx, null::get_null_float<T>());
    }

    util::Optional<T> get(size_t ndx) const noexcept
    {
        T val = BasicArray<T>::get(ndx);
        return null::is_null_float(val) ? util::none : util::make_optional(val);
    }
    Mixed get_any(size_t ndx) const override
    {
        return Mixed(get(ndx));
    }
    size_t find_first(util::Optional<T> value, size_t begin = 0, size_t end = npos) const
    {
        if (value) {
            return BasicArray<T>::find_first(*value, begin, end);
        }
        else {
            return find_first_null(begin, end);
        }
    }
    size_t find_first_null(size_t begin = 0, size_t end = npos) const;
};

// Class typedefs for BasicArray's: ArrayFloat and ArrayDouble
typedef BasicArray<float> ArrayFloat;
typedef BasicArray<double> ArrayDouble;
typedef BasicArrayNull<float> ArrayFloatNull;
typedef BasicArrayNull<double> ArrayDoubleNull;

} // namespace realm

#include <realm/array_basic_tpl.hpp>

#endif // REALM_ARRAY_BASIC_HPP
