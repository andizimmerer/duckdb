#include "duckdb/common/serializer/memory_stream.hpp"

namespace duckdb {

MemoryStream::MemoryStream(idx_t capacity) : position(0), capacity(capacity), owns_data(true) {
	D_ASSERT(capacity != 0 && IsPowerOfTwo(capacity));
	auto data_malloc_result = malloc(capacity);
	if (!data_malloc_result) {
		throw std::bad_alloc();
	}
	data = static_cast<data_ptr_t>(data_malloc_result);
}

MemoryStream::MemoryStream(data_ptr_t buffer, idx_t capacity)
    : position(0), capacity(capacity), owns_data(false), data(buffer) {
}

MemoryStream::~MemoryStream() {
	if (owns_data) {
		free(data);
	}
}

MemoryStream::MemoryStream(MemoryStream &&other) noexcept {
	// Move the data from the other stream into this stream
	data = other.data;
	position = other.position;
	capacity = other.capacity;
	owns_data = other.owns_data;

	// Reset the other stream
	other.data = nullptr;
	other.position = 0;
	other.capacity = 0;
	other.owns_data = false;
}

MemoryStream &MemoryStream::operator=(MemoryStream &&other) noexcept {
	if (this != &other) {
		// Free the current data
		if (owns_data) {
			free(data);
		}

		// Move the data from the other stream into this stream
		data = other.data;
		position = other.position;
		capacity = other.capacity;
		owns_data = other.owns_data;

		// Reset the other stream
		other.data = nullptr;
		other.position = 0;
		other.capacity = 0;
		other.owns_data = false;
	}
	return *this;
}

void MemoryStream::WriteData(const_data_ptr_t source, idx_t write_size) {
	while (position + write_size > capacity) {
		if (owns_data) {
			capacity *= 2;
			data = static_cast<data_ptr_t>(realloc(data, capacity));
		} else {
			throw SerializationException("Failed to serialize: not enough space in buffer to fulfill write request");
		}
	}
	memcpy(data + position, source, write_size);
	position += write_size;
}

void MemoryStream::ReadData(data_ptr_t destination, idx_t read_size) {
	if (position + read_size > capacity) {
		throw SerializationException("Failed to deserialize: not enough data in buffer to fulfill read request");
	}
	memcpy(destination, data + position, read_size);
	position += read_size;
}

void MemoryStream::Rewind() {
	position = 0;
}

void MemoryStream::Release() {
	owns_data = false;
}

data_ptr_t MemoryStream::GetData() const {
	return data;
}

idx_t MemoryStream::GetPosition() const {
	return position;
}

idx_t MemoryStream::GetCapacity() const {
	return capacity;
}

} // namespace duckdb
