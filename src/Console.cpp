//
// Created by os on 9/5/23.
//

#include "../h/Console.hpp"

// Singleton getter
Console& Console::getInstance()
{
    static Console instance;
    return instance;
}