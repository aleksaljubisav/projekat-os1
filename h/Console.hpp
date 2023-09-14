//
// Created by os on 9/5/23.
//

#ifndef PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP
#define PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP


class Console
{
public:
    static Console& getInstance();

    /*  deleted functions should generally be pubSlic
    as it results in better error messages      */
    Console(Console const&) = delete;
    void operator=(Console const&) = delete;

private:
    // Skriveni konstruktor
    Console() {}
};


#endif //PROJECT_BASE_REPOSITORY_PREDAJA_CONSOLE_HPP
