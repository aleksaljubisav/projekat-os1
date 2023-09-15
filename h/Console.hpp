//
// Created by os on 9/5/23.
//

#ifndef PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP
#define PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP

#include "../h/kBuffer.hpp"

class Con
{
public:
    static Con& getInstance();

    /*  deleted functions should generally be pubSlic
    as it results in better error messages      */
    Con(Con const&) = delete;
    void operator=(Con const&) = delete;

    void putc(char chr);

    char getc();

    void initBuffers();
    void delBuffers();

    kBuffer* outBuffer = nullptr;
    kBuffer* inBuffer = nullptr;

private:
    // Skriveni konstruktor
    Con() {}
};

#endif //PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP
