//
// Created by os on 9/5/23.
//

#include "../h/Console.hpp"
#include "../lib/console.h"

// Singleton getter
Con& Con::getInstance()
{
    static Con instance;
    return instance;
}

void Con::putc(char chr)
{
    //if(outBuffer->getCnt() < outBuffer->getCap()-1) {
    outBuffer->put(chr);

    //}
}

char Con::getc()
{
    //if(inBuffer->getCnt() > 0)
    char chr = inBuffer->get();
    return chr;
}


void Con::initBuffers()
{
    outBuffer = new kBuffer(200);
    inBuffer = new kBuffer(200);
}

void Con::delBuffers()
{
    delete outBuffer;
    delete inBuffer;
}