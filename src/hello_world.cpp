export module hello_world;

// Keep the namespace identical to the module name.
export namespace hello_world {
    const char* msg();
}

const char* hello_world::msg() { return "Hello World!"; }
