
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	38013103          	ld	sp,896(sp) # 80004380 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4bc010ef          	jal	ra,800014d8 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
#include "../h/MemoryAllocator.hpp"
#include "../h/print.hpp"
int main()
{
    80001000:	ff010113          	addi	sp,sp,-16
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00813023          	sd	s0,0(sp)
    8000100c:	01010413          	addi	s0,sp,16
    MemoryAllocator::getInstance();
    80001010:	00000097          	auipc	ra,0x0
    80001014:	0ac080e7          	jalr	172(ra) # 800010bc <_ZN15MemoryAllocator11getInstanceEv>
    printInteger(sizeof(MemoryAllocator::BlockHeader));
    80001018:	01800513          	li	a0,24
    8000101c:	00000097          	auipc	ra,0x0
    80001020:	42c080e7          	jalr	1068(ra) # 80001448 <_Z12printIntegerm>
    printString("\n");
    80001024:	00003517          	auipc	a0,0x3
    80001028:	11c50513          	addi	a0,a0,284 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    8000102c:	00000097          	auipc	ra,0x0
    80001030:	3d8080e7          	jalr	984(ra) # 80001404 <_Z11printStringPKc>
    printInteger(sizeof(MemoryAllocator));
    80001034:	00100513          	li	a0,1
    80001038:	00000097          	auipc	ra,0x0
    8000103c:	410080e7          	jalr	1040(ra) # 80001448 <_Z12printIntegerm>
    printString("\n");
    80001040:	00003517          	auipc	a0,0x3
    80001044:	10050513          	addi	a0,a0,256 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80001048:	00000097          	auipc	ra,0x0
    8000104c:	3bc080e7          	jalr	956(ra) # 80001404 <_Z11printStringPKc>
    return 0;
    80001050:	00000513          	li	a0,0
    80001054:	00813083          	ld	ra,8(sp)
    80001058:	00013403          	ld	s0,0(sp)
    8000105c:	01010113          	addi	sp,sp,16
    80001060:	00008067          	ret

0000000080001064 <_ZN15MemoryAllocatorC1Ev>:
    static MemoryAllocator instance;
    return instance;
}

// Class constructor
MemoryAllocator::MemoryAllocator()
    80001064:	ff010113          	addi	sp,sp,-16
    80001068:	00813423          	sd	s0,8(sp)
    8000106c:	01010413          	addi	s0,sp,16
{
    freeMemHead = (BlockHeader*)(HEAP_START_ADDR);
    80001070:	00003697          	auipc	a3,0x3
    80001074:	3086b683          	ld	a3,776(a3) # 80004378 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001078:	0006b703          	ld	a4,0(a3)
    8000107c:	00003797          	auipc	a5,0x3
    80001080:	35478793          	addi	a5,a5,852 # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    80001084:	00e7b023          	sd	a4,0(a5)
    freeMemHead->next = nullptr;
    80001088:	00073023          	sd	zero,0(a4)
    freeMemHead->prev = nullptr;
    8000108c:	0007b703          	ld	a4,0(a5)
    80001090:	00073423          	sd	zero,8(a4)
    freeMemHead->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - sizeof(BlockHeader);
    80001094:	00003797          	auipc	a5,0x3
    80001098:	2f47b783          	ld	a5,756(a5) # 80004388 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000109c:	0007b783          	ld	a5,0(a5)
    800010a0:	0006b683          	ld	a3,0(a3)
    800010a4:	40d787b3          	sub	a5,a5,a3
    800010a8:	fe878793          	addi	a5,a5,-24
    800010ac:	00f73823          	sd	a5,16(a4)
}
    800010b0:	00813403          	ld	s0,8(sp)
    800010b4:	01010113          	addi	sp,sp,16
    800010b8:	00008067          	ret

00000000800010bc <_ZN15MemoryAllocator11getInstanceEv>:
    static MemoryAllocator instance;
    800010bc:	00003797          	auipc	a5,0x3
    800010c0:	31c7c783          	lbu	a5,796(a5) # 800043d8 <_ZGVZN15MemoryAllocator11getInstanceEvE8instance>
    800010c4:	00078863          	beqz	a5,800010d4 <_ZN15MemoryAllocator11getInstanceEv+0x18>
}
    800010c8:	00003517          	auipc	a0,0x3
    800010cc:	31850513          	addi	a0,a0,792 # 800043e0 <_ZZN15MemoryAllocator11getInstanceEvE8instance>
    800010d0:	00008067          	ret
{
    800010d4:	ff010113          	addi	sp,sp,-16
    800010d8:	00113423          	sd	ra,8(sp)
    800010dc:	00813023          	sd	s0,0(sp)
    800010e0:	01010413          	addi	s0,sp,16
    static MemoryAllocator instance;
    800010e4:	00003517          	auipc	a0,0x3
    800010e8:	2fc50513          	addi	a0,a0,764 # 800043e0 <_ZZN15MemoryAllocator11getInstanceEvE8instance>
    800010ec:	00000097          	auipc	ra,0x0
    800010f0:	f78080e7          	jalr	-136(ra) # 80001064 <_ZN15MemoryAllocatorC1Ev>
    800010f4:	00100793          	li	a5,1
    800010f8:	00003717          	auipc	a4,0x3
    800010fc:	2ef70023          	sb	a5,736(a4) # 800043d8 <_ZGVZN15MemoryAllocator11getInstanceEvE8instance>
}
    80001100:	00003517          	auipc	a0,0x3
    80001104:	2e050513          	addi	a0,a0,736 # 800043e0 <_ZZN15MemoryAllocator11getInstanceEvE8instance>
    80001108:	00813083          	ld	ra,8(sp)
    8000110c:	00013403          	ld	s0,0(sp)
    80001110:	01010113          	addi	sp,sp,16
    80001114:	00008067          	ret

0000000080001118 <_ZN15MemoryAllocator11__mem_allocEm>:
    else head = blk;
}

// Memory allocation---------------------------------------------------------------------------------------
void* MemoryAllocator::__mem_alloc(size_t size)
{
    80001118:	ff010113          	addi	sp,sp,-16
    8000111c:	00813423          	sd	s0,8(sp)
    80001120:	01010413          	addi	s0,sp,16
    80001124:	00050713          	mv	a4,a0
    BlockHeader* blk = freeMemHead;
    80001128:	00003517          	auipc	a0,0x3
    8000112c:	2a853503          	ld	a0,680(a0) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    for(; blk!=nullptr; blk = blk->next)
    80001130:	00050a63          	beqz	a0,80001144 <_ZN15MemoryAllocator11__mem_allocEm+0x2c>
        if(blk->size >= size) break;
    80001134:	01053783          	ld	a5,16(a0)
    80001138:	00e7f663          	bgeu	a5,a4,80001144 <_ZN15MemoryAllocator11__mem_allocEm+0x2c>
    for(; blk!=nullptr; blk = blk->next)
    8000113c:	00053503          	ld	a0,0(a0)
    80001140:	ff1ff06f          	j	80001130 <_ZN15MemoryAllocator11__mem_allocEm+0x18>
    // Try to find an existing free block in list (first fit):
    BlockHeader* blk = findFirstFit(size);
    if(blk == nullptr) return nullptr; // If not found
    80001144:	10050a63          	beqz	a0,80001258 <_ZN15MemoryAllocator11__mem_allocEm+0x140>
    size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    80001148:	03f77793          	andi	a5,a4,63
    8000114c:	08078c63          	beqz	a5,800011e4 <_ZN15MemoryAllocator11__mem_allocEm+0xcc>
    80001150:	fc077793          	andi	a5,a4,-64
    80001154:	04078793          	addi	a5,a5,64
    size_t remainingSize = blk->size - allocSize;
    80001158:	01053683          	ld	a3,16(a0)
    8000115c:	40f686b3          	sub	a3,a3,a5
    if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE)
    80001160:	05700613          	li	a2,87
    80001164:	08d67a63          	bgeu	a2,a3,800011f8 <_ZN15MemoryAllocator11__mem_allocEm+0xe0>
        blk->size = size;
    80001168:	00e53823          	sd	a4,16(a0)
        size_t offset = sizeof(BlockHeader) + allocSize;
    8000116c:	01878793          	addi	a5,a5,24
        auto* newBlk = (BlockHeader*)((char*)blk + offset);
    80001170:	00f507b3          	add	a5,a0,a5
        if(blk->prev) blk->prev->next = newBlk;
    80001174:	00853703          	ld	a4,8(a0)
    80001178:	06070a63          	beqz	a4,800011ec <_ZN15MemoryAllocator11__mem_allocEm+0xd4>
    8000117c:	00f73023          	sd	a5,0(a4)
        newBlk->prev = blk->prev;
    80001180:	00853703          	ld	a4,8(a0)
    80001184:	00e7b423          	sd	a4,8(a5)
        if(blk->next) blk->next->prev = newBlk;
    80001188:	00053703          	ld	a4,0(a0)
    8000118c:	00070463          	beqz	a4,80001194 <_ZN15MemoryAllocator11__mem_allocEm+0x7c>
    80001190:	00f73423          	sd	a5,8(a4)
        newBlk->next = blk->next;
    80001194:	00053703          	ld	a4,0(a0)
    80001198:	00e7b023          	sd	a4,0(a5)
        newBlk->size = remainingSize - sizeof(BlockHeader);
    8000119c:	fe868693          	addi	a3,a3,-24
    800011a0:	00d7b823          	sd	a3,16(a5)
    blk->next = nullptr;
    800011a4:	00053023          	sd	zero,0(a0)
    blk->prev = nullptr;
    800011a8:	00053423          	sd	zero,8(a0)
    BlockHeader* cur = head;
    800011ac:	00003797          	auipc	a5,0x3
    800011b0:	23c7b783          	ld	a5,572(a5) # 800043e8 <_ZN15MemoryAllocator12allocMemHeadE>
    if(!head || (char*)blk < (char*)head)
    800011b4:	0a078863          	beqz	a5,80001264 <_ZN15MemoryAllocator11__mem_allocEm+0x14c>
    800011b8:	06f56a63          	bltu	a0,a5,8000122c <_ZN15MemoryAllocator11__mem_allocEm+0x114>
        for(; cur->next!=nullptr && (char*)blk > (char*)(cur->next); cur = cur->next);
    800011bc:	00078713          	mv	a4,a5
    800011c0:	0007b783          	ld	a5,0(a5)
    800011c4:	00078463          	beqz	a5,800011cc <_ZN15MemoryAllocator11__mem_allocEm+0xb4>
    800011c8:	fea7eae3          	bltu	a5,a0,800011bc <_ZN15MemoryAllocator11__mem_allocEm+0xa4>
    blk->prev = cur;
    800011cc:	00e53423          	sd	a4,8(a0)
    if(cur) blk->next = cur->next;
    800011d0:	08070e63          	beqz	a4,8000126c <_ZN15MemoryAllocator11__mem_allocEm+0x154>
    800011d4:	00073783          	ld	a5,0(a4)
    800011d8:	00f53023          	sd	a5,0(a0)
    800011dc:	00070793          	mv	a5,a4
    800011e0:	0600006f          	j	80001240 <_ZN15MemoryAllocator11__mem_allocEm+0x128>
    size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    800011e4:	00070793          	mv	a5,a4
    800011e8:	f71ff06f          	j	80001158 <_ZN15MemoryAllocator11__mem_allocEm+0x40>
        else freeMemHead = newBlk;
    800011ec:	00003717          	auipc	a4,0x3
    800011f0:	1ef73223          	sd	a5,484(a4) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    800011f4:	f8dff06f          	j	80001180 <_ZN15MemoryAllocator11__mem_allocEm+0x68>
        if(blk->prev) blk->prev->next = blk->next;
    800011f8:	00853783          	ld	a5,8(a0)
    800011fc:	02078063          	beqz	a5,8000121c <_ZN15MemoryAllocator11__mem_allocEm+0x104>
    80001200:	00053703          	ld	a4,0(a0)
    80001204:	00e7b023          	sd	a4,0(a5)
        if(blk->next) blk->next->prev = blk->prev;
    80001208:	00053783          	ld	a5,0(a0)
    8000120c:	f8078ce3          	beqz	a5,800011a4 <_ZN15MemoryAllocator11__mem_allocEm+0x8c>
    80001210:	00853703          	ld	a4,8(a0)
    80001214:	00e7b423          	sd	a4,8(a5)
    80001218:	f8dff06f          	j	800011a4 <_ZN15MemoryAllocator11__mem_allocEm+0x8c>
        else freeMemHead = blk->next;
    8000121c:	00053783          	ld	a5,0(a0)
    80001220:	00003717          	auipc	a4,0x3
    80001224:	1af73823          	sd	a5,432(a4) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    80001228:	fe1ff06f          	j	80001208 <_ZN15MemoryAllocator11__mem_allocEm+0xf0>
    blk->prev = cur;
    8000122c:	00053423          	sd	zero,8(a0)
        cur = nullptr;
    80001230:	00000793          	li	a5,0
    else blk->next = head;
    80001234:	00003717          	auipc	a4,0x3
    80001238:	1b473703          	ld	a4,436(a4) # 800043e8 <_ZN15MemoryAllocator12allocMemHeadE>
    8000123c:	00e53023          	sd	a4,0(a0)
    if(blk->next) blk->next->prev = blk;
    80001240:	00053703          	ld	a4,0(a0)
    80001244:	00070463          	beqz	a4,8000124c <_ZN15MemoryAllocator11__mem_allocEm+0x134>
    80001248:	00a73423          	sd	a0,8(a4)
    if(cur) cur->next = blk;
    8000124c:	02078463          	beqz	a5,80001274 <_ZN15MemoryAllocator11__mem_allocEm+0x15c>
    80001250:	00a7b023          	sd	a0,0(a5)
    getFromFreeList(blk, size);

    // Put block in allocated memory list
    putIntoOrderedList(blk, allocMemHead);

    return (char*)blk + sizeof(BlockHeader);
    80001254:	01850513          	addi	a0,a0,24
}
    80001258:	00813403          	ld	s0,8(sp)
    8000125c:	01010113          	addi	sp,sp,16
    80001260:	00008067          	ret
    blk->prev = cur;
    80001264:	00053423          	sd	zero,8(a0)
    if(cur) blk->next = cur->next;
    80001268:	fcdff06f          	j	80001234 <_ZN15MemoryAllocator11__mem_allocEm+0x11c>
    8000126c:	00070793          	mv	a5,a4
    80001270:	fc5ff06f          	j	80001234 <_ZN15MemoryAllocator11__mem_allocEm+0x11c>
    else head = blk;
    80001274:	00003797          	auipc	a5,0x3
    80001278:	16a7ba23          	sd	a0,372(a5) # 800043e8 <_ZN15MemoryAllocator12allocMemHeadE>
    8000127c:	fd9ff06f          	j	80001254 <_ZN15MemoryAllocator11__mem_allocEm+0x13c>

0000000080001280 <_ZN15MemoryAllocator10__mem_freeEPv>:
}


// Memory deallocation
int MemoryAllocator::__mem_free(void* address)
{
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    BlockHeader* blk = allocMemHead;
    8000128c:	00003797          	auipc	a5,0x3
    80001290:	15c7b783          	ld	a5,348(a5) # 800043e8 <_ZN15MemoryAllocator12allocMemHeadE>
    for(; blk!=nullptr && (char*)address != (char*)blk + blk->size; blk = blk->next);
    80001294:	00078c63          	beqz	a5,800012ac <_ZN15MemoryAllocator10__mem_freeEPv+0x2c>
    80001298:	0107b703          	ld	a4,16(a5)
    8000129c:	00e78733          	add	a4,a5,a4
    800012a0:	00e50663          	beq	a0,a4,800012ac <_ZN15MemoryAllocator10__mem_freeEPv+0x2c>
    800012a4:	0007b783          	ld	a5,0(a5)
    800012a8:	fedff06f          	j	80001294 <_ZN15MemoryAllocator10__mem_freeEPv+0x14>
    if(!blk) return nullptr;
    800012ac:	02078663          	beqz	a5,800012d8 <_ZN15MemoryAllocator10__mem_freeEPv+0x58>
    if(blk->prev) blk->prev->next = blk->next;
    800012b0:	0087b703          	ld	a4,8(a5)
    800012b4:	06070063          	beqz	a4,80001314 <_ZN15MemoryAllocator10__mem_freeEPv+0x94>
    800012b8:	0007b683          	ld	a3,0(a5)
    800012bc:	00d73023          	sd	a3,0(a4)
    if(blk->next) blk->next->prev = blk->prev;
    800012c0:	0007b703          	ld	a4,0(a5)
    800012c4:	00070663          	beqz	a4,800012d0 <_ZN15MemoryAllocator10__mem_freeEPv+0x50>
    800012c8:	0087b683          	ld	a3,8(a5)
    800012cc:	00d73423          	sd	a3,8(a4)
    blk->next = nullptr;
    800012d0:	0007b023          	sd	zero,0(a5)
    blk->prev = nullptr;
    800012d4:	0007b423          	sd	zero,8(a5)
    // Get block from allocated list
    BlockHeader* blk = getFromAllocList(address);
    if(!blk) return -1;
    800012d8:	10078a63          	beqz	a5,800013ec <_ZN15MemoryAllocator10__mem_freeEPv+0x16c>
    BlockHeader* cur = head;
    800012dc:	00003717          	auipc	a4,0x3
    800012e0:	0f473703          	ld	a4,244(a4) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    if(!head || (char*)blk < (char*)head)
    800012e4:	0a070463          	beqz	a4,8000138c <_ZN15MemoryAllocator10__mem_freeEPv+0x10c>
    800012e8:	02e7ee63          	bltu	a5,a4,80001324 <_ZN15MemoryAllocator10__mem_freeEPv+0xa4>
        for(; cur->next!=nullptr && (char*)blk > (char*)(cur->next); cur = cur->next);
    800012ec:	00070693          	mv	a3,a4
    800012f0:	00073703          	ld	a4,0(a4)
    800012f4:	00070463          	beqz	a4,800012fc <_ZN15MemoryAllocator10__mem_freeEPv+0x7c>
    800012f8:	fef76ae3          	bltu	a4,a5,800012ec <_ZN15MemoryAllocator10__mem_freeEPv+0x6c>
    blk->prev = cur;
    800012fc:	00d7b423          	sd	a3,8(a5)
    if(cur) blk->next = cur->next;
    80001300:	08068a63          	beqz	a3,80001394 <_ZN15MemoryAllocator10__mem_freeEPv+0x114>
    80001304:	0006b703          	ld	a4,0(a3)
    80001308:	00e7b023          	sd	a4,0(a5)
    8000130c:	00068713          	mv	a4,a3
    80001310:	0280006f          	j	80001338 <_ZN15MemoryAllocator10__mem_freeEPv+0xb8>
    else freeMemHead = blk->next;
    80001314:	0007b703          	ld	a4,0(a5)
    80001318:	00003697          	auipc	a3,0x3
    8000131c:	0ae6bc23          	sd	a4,184(a3) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    80001320:	fa1ff06f          	j	800012c0 <_ZN15MemoryAllocator10__mem_freeEPv+0x40>
    blk->prev = cur;
    80001324:	0007b423          	sd	zero,8(a5)
        cur = nullptr;
    80001328:	00000713          	li	a4,0
    else blk->next = head;
    8000132c:	00003697          	auipc	a3,0x3
    80001330:	0a46b683          	ld	a3,164(a3) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    80001334:	00d7b023          	sd	a3,0(a5)
    if(blk->next) blk->next->prev = blk;
    80001338:	0007b683          	ld	a3,0(a5)
    8000133c:	00068463          	beqz	a3,80001344 <_ZN15MemoryAllocator10__mem_freeEPv+0xc4>
    80001340:	00f6b423          	sd	a5,8(a3)
    if(cur) cur->next = blk;
    80001344:	04070c63          	beqz	a4,8000139c <_ZN15MemoryAllocator10__mem_freeEPv+0x11c>
    80001348:	00f73023          	sd	a5,0(a4)

    // Find where and insert the new segment after cur:
    putIntoOrderedList(blk, freeMemHead);

    // Try to merge with the previous and next segments
    tryToJoin(blk->prev);
    8000134c:	0087b703          	ld	a4,8(a5)
    if(!cur) return 0;
    80001350:	00070c63          	beqz	a4,80001368 <_ZN15MemoryAllocator10__mem_freeEPv+0xe8>
    if(cur->next && (char*)cur + cur->size == (char*)(cur->next))
    80001354:	00073683          	ld	a3,0(a4)
    80001358:	00068863          	beqz	a3,80001368 <_ZN15MemoryAllocator10__mem_freeEPv+0xe8>
    8000135c:	01073603          	ld	a2,16(a4)
    80001360:	00c705b3          	add	a1,a4,a2
    80001364:	04b68263          	beq	a3,a1,800013a8 <_ZN15MemoryAllocator10__mem_freeEPv+0x128>
    80001368:	0007b703          	ld	a4,0(a5)
    8000136c:	08070463          	beqz	a4,800013f4 <_ZN15MemoryAllocator10__mem_freeEPv+0x174>
    80001370:	0107b683          	ld	a3,16(a5)
    80001374:	00d78633          	add	a2,a5,a3
    80001378:	04c70863          	beq	a4,a2,800013c8 <_ZN15MemoryAllocator10__mem_freeEPv+0x148>
    tryToJoin(blk);

    return 0;
    8000137c:	00000513          	li	a0,0
}
    80001380:	00813403          	ld	s0,8(sp)
    80001384:	01010113          	addi	sp,sp,16
    80001388:	00008067          	ret
    blk->prev = cur;
    8000138c:	0007b423          	sd	zero,8(a5)
    if(cur) blk->next = cur->next;
    80001390:	f9dff06f          	j	8000132c <_ZN15MemoryAllocator10__mem_freeEPv+0xac>
    80001394:	00068713          	mv	a4,a3
    80001398:	f95ff06f          	j	8000132c <_ZN15MemoryAllocator10__mem_freeEPv+0xac>
    else head = blk;
    8000139c:	00003717          	auipc	a4,0x3
    800013a0:	02f73a23          	sd	a5,52(a4) # 800043d0 <_ZN15MemoryAllocator11freeMemHeadE>
    800013a4:	fa9ff06f          	j	8000134c <_ZN15MemoryAllocator10__mem_freeEPv+0xcc>
        cur->size += cur->next->size;
    800013a8:	0106b583          	ld	a1,16(a3)
    800013ac:	00b60633          	add	a2,a2,a1
    800013b0:	00c73823          	sd	a2,16(a4)
        cur->next = cur->next->next;
    800013b4:	0006b683          	ld	a3,0(a3)
    800013b8:	00d73023          	sd	a3,0(a4)
        if(cur->next) cur->next->prev = cur;
    800013bc:	fa0686e3          	beqz	a3,80001368 <_ZN15MemoryAllocator10__mem_freeEPv+0xe8>
    800013c0:	00e6b423          	sd	a4,8(a3)
    800013c4:	fa5ff06f          	j	80001368 <_ZN15MemoryAllocator10__mem_freeEPv+0xe8>
        cur->size += cur->next->size;
    800013c8:	01073603          	ld	a2,16(a4)
    800013cc:	00c686b3          	add	a3,a3,a2
    800013d0:	00d7b823          	sd	a3,16(a5)
        cur->next = cur->next->next;
    800013d4:	00073703          	ld	a4,0(a4)
    800013d8:	00e7b023          	sd	a4,0(a5)
        if(cur->next) cur->next->prev = cur;
    800013dc:	02070063          	beqz	a4,800013fc <_ZN15MemoryAllocator10__mem_freeEPv+0x17c>
    800013e0:	00f73423          	sd	a5,8(a4)
    return 0;
    800013e4:	00000513          	li	a0,0
    800013e8:	f99ff06f          	j	80001380 <_ZN15MemoryAllocator10__mem_freeEPv+0x100>
    if(!blk) return -1;
    800013ec:	fff00513          	li	a0,-1
    800013f0:	f91ff06f          	j	80001380 <_ZN15MemoryAllocator10__mem_freeEPv+0x100>
    return 0;
    800013f4:	00000513          	li	a0,0
    800013f8:	f89ff06f          	j	80001380 <_ZN15MemoryAllocator10__mem_freeEPv+0x100>
    800013fc:	00000513          	li	a0,0
    80001400:	f81ff06f          	j	80001380 <_ZN15MemoryAllocator10__mem_freeEPv+0x100>

0000000080001404 <_Z11printStringPKc>:
#include "../h/print.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"

void printString(char const *string)
{
    80001404:	fe010113          	addi	sp,sp,-32
    80001408:	00113c23          	sd	ra,24(sp)
    8000140c:	00813823          	sd	s0,16(sp)
    80001410:	00913423          	sd	s1,8(sp)
    80001414:	02010413          	addi	s0,sp,32
    80001418:	00050493          	mv	s1,a0
    //uint64 sstatus = Riscv::r_sstatus();
    //Riscv::mc_sstatus(Riscv::SSTATUS_SIE);

    while (*string != '\0')
    8000141c:	0004c503          	lbu	a0,0(s1)
    80001420:	00050a63          	beqz	a0,80001434 <_Z11printStringPKc+0x30>
    {
        __putc(*string);
    80001424:	00002097          	auipc	ra,0x2
    80001428:	178080e7          	jalr	376(ra) # 8000359c <__putc>
        string++;
    8000142c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001430:	fedff06f          	j	8000141c <_Z11printStringPKc+0x18>
    }

    //Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
}
    80001434:	01813083          	ld	ra,24(sp)
    80001438:	01013403          	ld	s0,16(sp)
    8000143c:	00813483          	ld	s1,8(sp)
    80001440:	02010113          	addi	sp,sp,32
    80001444:	00008067          	ret

0000000080001448 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    80001448:	fd010113          	addi	sp,sp,-48
    8000144c:	02113423          	sd	ra,40(sp)
    80001450:	02813023          	sd	s0,32(sp)
    80001454:	00913c23          	sd	s1,24(sp)
    80001458:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    8000145c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001460:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001464:	00a00613          	li	a2,10
    80001468:	02c5773b          	remuw	a4,a0,a2
    8000146c:	02071693          	slli	a3,a4,0x20
    80001470:	0206d693          	srli	a3,a3,0x20
    80001474:	00003717          	auipc	a4,0x3
    80001478:	bac70713          	addi	a4,a4,-1108 # 80004020 <_ZZ12printIntegermE6digits>
    8000147c:	00d70733          	add	a4,a4,a3
    80001480:	00074703          	lbu	a4,0(a4)
    80001484:	fe040693          	addi	a3,s0,-32
    80001488:	009687b3          	add	a5,a3,s1
    8000148c:	0014849b          	addiw	s1,s1,1
    80001490:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001494:	0005071b          	sext.w	a4,a0
    80001498:	02c5553b          	divuw	a0,a0,a2
    8000149c:	00900793          	li	a5,9
    800014a0:	fce7e2e3          	bltu	a5,a4,80001464 <_Z12printIntegerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0)
    800014a4:	fff4849b          	addiw	s1,s1,-1
    800014a8:	0004ce63          	bltz	s1,800014c4 <_Z12printIntegerm+0x7c>
        __putc(buf[i]);
    800014ac:	fe040793          	addi	a5,s0,-32
    800014b0:	009787b3          	add	a5,a5,s1
    800014b4:	ff07c503          	lbu	a0,-16(a5)
    800014b8:	00002097          	auipc	ra,0x2
    800014bc:	0e4080e7          	jalr	228(ra) # 8000359c <__putc>
    800014c0:	fe5ff06f          	j	800014a4 <_Z12printIntegerm+0x5c>

    //Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
    800014c4:	02813083          	ld	ra,40(sp)
    800014c8:	02013403          	ld	s0,32(sp)
    800014cc:	01813483          	ld	s1,24(sp)
    800014d0:	03010113          	addi	sp,sp,48
    800014d4:	00008067          	ret

00000000800014d8 <start>:
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00813423          	sd	s0,8(sp)
    800014e0:	01010413          	addi	s0,sp,16
    800014e4:	300027f3          	csrr	a5,mstatus
    800014e8:	ffffe737          	lui	a4,0xffffe
    800014ec:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff91bf>
    800014f0:	00e7f7b3          	and	a5,a5,a4
    800014f4:	00001737          	lui	a4,0x1
    800014f8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800014fc:	00e7e7b3          	or	a5,a5,a4
    80001500:	30079073          	csrw	mstatus,a5
    80001504:	00000797          	auipc	a5,0x0
    80001508:	16078793          	addi	a5,a5,352 # 80001664 <system_main>
    8000150c:	34179073          	csrw	mepc,a5
    80001510:	00000793          	li	a5,0
    80001514:	18079073          	csrw	satp,a5
    80001518:	000107b7          	lui	a5,0x10
    8000151c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001520:	30279073          	csrw	medeleg,a5
    80001524:	30379073          	csrw	mideleg,a5
    80001528:	104027f3          	csrr	a5,sie
    8000152c:	2227e793          	ori	a5,a5,546
    80001530:	10479073          	csrw	sie,a5
    80001534:	fff00793          	li	a5,-1
    80001538:	00a7d793          	srli	a5,a5,0xa
    8000153c:	3b079073          	csrw	pmpaddr0,a5
    80001540:	00f00793          	li	a5,15
    80001544:	3a079073          	csrw	pmpcfg0,a5
    80001548:	f14027f3          	csrr	a5,mhartid
    8000154c:	0200c737          	lui	a4,0x200c
    80001550:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001554:	0007869b          	sext.w	a3,a5
    80001558:	00269713          	slli	a4,a3,0x2
    8000155c:	000f4637          	lui	a2,0xf4
    80001560:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001564:	00d70733          	add	a4,a4,a3
    80001568:	0037979b          	slliw	a5,a5,0x3
    8000156c:	020046b7          	lui	a3,0x2004
    80001570:	00d787b3          	add	a5,a5,a3
    80001574:	00c585b3          	add	a1,a1,a2
    80001578:	00371693          	slli	a3,a4,0x3
    8000157c:	00003717          	auipc	a4,0x3
    80001580:	e7470713          	addi	a4,a4,-396 # 800043f0 <timer_scratch>
    80001584:	00b7b023          	sd	a1,0(a5)
    80001588:	00d70733          	add	a4,a4,a3
    8000158c:	00f73c23          	sd	a5,24(a4)
    80001590:	02c73023          	sd	a2,32(a4)
    80001594:	34071073          	csrw	mscratch,a4
    80001598:	00000797          	auipc	a5,0x0
    8000159c:	6e878793          	addi	a5,a5,1768 # 80001c80 <timervec>
    800015a0:	30579073          	csrw	mtvec,a5
    800015a4:	300027f3          	csrr	a5,mstatus
    800015a8:	0087e793          	ori	a5,a5,8
    800015ac:	30079073          	csrw	mstatus,a5
    800015b0:	304027f3          	csrr	a5,mie
    800015b4:	0807e793          	ori	a5,a5,128
    800015b8:	30479073          	csrw	mie,a5
    800015bc:	f14027f3          	csrr	a5,mhartid
    800015c0:	0007879b          	sext.w	a5,a5
    800015c4:	00078213          	mv	tp,a5
    800015c8:	30200073          	mret
    800015cc:	00813403          	ld	s0,8(sp)
    800015d0:	01010113          	addi	sp,sp,16
    800015d4:	00008067          	ret

00000000800015d8 <timerinit>:
    800015d8:	ff010113          	addi	sp,sp,-16
    800015dc:	00813423          	sd	s0,8(sp)
    800015e0:	01010413          	addi	s0,sp,16
    800015e4:	f14027f3          	csrr	a5,mhartid
    800015e8:	0200c737          	lui	a4,0x200c
    800015ec:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800015f0:	0007869b          	sext.w	a3,a5
    800015f4:	00269713          	slli	a4,a3,0x2
    800015f8:	000f4637          	lui	a2,0xf4
    800015fc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001600:	00d70733          	add	a4,a4,a3
    80001604:	0037979b          	slliw	a5,a5,0x3
    80001608:	020046b7          	lui	a3,0x2004
    8000160c:	00d787b3          	add	a5,a5,a3
    80001610:	00c585b3          	add	a1,a1,a2
    80001614:	00371693          	slli	a3,a4,0x3
    80001618:	00003717          	auipc	a4,0x3
    8000161c:	dd870713          	addi	a4,a4,-552 # 800043f0 <timer_scratch>
    80001620:	00b7b023          	sd	a1,0(a5)
    80001624:	00d70733          	add	a4,a4,a3
    80001628:	00f73c23          	sd	a5,24(a4)
    8000162c:	02c73023          	sd	a2,32(a4)
    80001630:	34071073          	csrw	mscratch,a4
    80001634:	00000797          	auipc	a5,0x0
    80001638:	64c78793          	addi	a5,a5,1612 # 80001c80 <timervec>
    8000163c:	30579073          	csrw	mtvec,a5
    80001640:	300027f3          	csrr	a5,mstatus
    80001644:	0087e793          	ori	a5,a5,8
    80001648:	30079073          	csrw	mstatus,a5
    8000164c:	304027f3          	csrr	a5,mie
    80001650:	0807e793          	ori	a5,a5,128
    80001654:	30479073          	csrw	mie,a5
    80001658:	00813403          	ld	s0,8(sp)
    8000165c:	01010113          	addi	sp,sp,16
    80001660:	00008067          	ret

0000000080001664 <system_main>:
    80001664:	fe010113          	addi	sp,sp,-32
    80001668:	00813823          	sd	s0,16(sp)
    8000166c:	00913423          	sd	s1,8(sp)
    80001670:	00113c23          	sd	ra,24(sp)
    80001674:	02010413          	addi	s0,sp,32
    80001678:	00000097          	auipc	ra,0x0
    8000167c:	0c4080e7          	jalr	196(ra) # 8000173c <cpuid>
    80001680:	00003497          	auipc	s1,0x3
    80001684:	d2048493          	addi	s1,s1,-736 # 800043a0 <started>
    80001688:	02050263          	beqz	a0,800016ac <system_main+0x48>
    8000168c:	0004a783          	lw	a5,0(s1)
    80001690:	0007879b          	sext.w	a5,a5
    80001694:	fe078ce3          	beqz	a5,8000168c <system_main+0x28>
    80001698:	0ff0000f          	fence
    8000169c:	00003517          	auipc	a0,0x3
    800016a0:	9c450513          	addi	a0,a0,-1596 # 80004060 <_ZZ12printIntegermE6digits+0x40>
    800016a4:	00001097          	auipc	ra,0x1
    800016a8:	a78080e7          	jalr	-1416(ra) # 8000211c <panic>
    800016ac:	00001097          	auipc	ra,0x1
    800016b0:	9cc080e7          	jalr	-1588(ra) # 80002078 <consoleinit>
    800016b4:	00001097          	auipc	ra,0x1
    800016b8:	158080e7          	jalr	344(ra) # 8000280c <printfinit>
    800016bc:	00003517          	auipc	a0,0x3
    800016c0:	a8450513          	addi	a0,a0,-1404 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    800016c4:	00001097          	auipc	ra,0x1
    800016c8:	ab4080e7          	jalr	-1356(ra) # 80002178 <__printf>
    800016cc:	00003517          	auipc	a0,0x3
    800016d0:	96450513          	addi	a0,a0,-1692 # 80004030 <_ZZ12printIntegermE6digits+0x10>
    800016d4:	00001097          	auipc	ra,0x1
    800016d8:	aa4080e7          	jalr	-1372(ra) # 80002178 <__printf>
    800016dc:	00003517          	auipc	a0,0x3
    800016e0:	a6450513          	addi	a0,a0,-1436 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    800016e4:	00001097          	auipc	ra,0x1
    800016e8:	a94080e7          	jalr	-1388(ra) # 80002178 <__printf>
    800016ec:	00001097          	auipc	ra,0x1
    800016f0:	4ac080e7          	jalr	1196(ra) # 80002b98 <kinit>
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	148080e7          	jalr	328(ra) # 8000183c <trapinit>
    800016fc:	00000097          	auipc	ra,0x0
    80001700:	16c080e7          	jalr	364(ra) # 80001868 <trapinithart>
    80001704:	00000097          	auipc	ra,0x0
    80001708:	5bc080e7          	jalr	1468(ra) # 80001cc0 <plicinit>
    8000170c:	00000097          	auipc	ra,0x0
    80001710:	5dc080e7          	jalr	1500(ra) # 80001ce8 <plicinithart>
    80001714:	00000097          	auipc	ra,0x0
    80001718:	078080e7          	jalr	120(ra) # 8000178c <userinit>
    8000171c:	0ff0000f          	fence
    80001720:	00100793          	li	a5,1
    80001724:	00003517          	auipc	a0,0x3
    80001728:	92450513          	addi	a0,a0,-1756 # 80004048 <_ZZ12printIntegermE6digits+0x28>
    8000172c:	00f4a023          	sw	a5,0(s1)
    80001730:	00001097          	auipc	ra,0x1
    80001734:	a48080e7          	jalr	-1464(ra) # 80002178 <__printf>
    80001738:	0000006f          	j	80001738 <system_main+0xd4>

000000008000173c <cpuid>:
    8000173c:	ff010113          	addi	sp,sp,-16
    80001740:	00813423          	sd	s0,8(sp)
    80001744:	01010413          	addi	s0,sp,16
    80001748:	00020513          	mv	a0,tp
    8000174c:	00813403          	ld	s0,8(sp)
    80001750:	0005051b          	sext.w	a0,a0
    80001754:	01010113          	addi	sp,sp,16
    80001758:	00008067          	ret

000000008000175c <mycpu>:
    8000175c:	ff010113          	addi	sp,sp,-16
    80001760:	00813423          	sd	s0,8(sp)
    80001764:	01010413          	addi	s0,sp,16
    80001768:	00020793          	mv	a5,tp
    8000176c:	00813403          	ld	s0,8(sp)
    80001770:	0007879b          	sext.w	a5,a5
    80001774:	00779793          	slli	a5,a5,0x7
    80001778:	00004517          	auipc	a0,0x4
    8000177c:	ca850513          	addi	a0,a0,-856 # 80005420 <cpus>
    80001780:	00f50533          	add	a0,a0,a5
    80001784:	01010113          	addi	sp,sp,16
    80001788:	00008067          	ret

000000008000178c <userinit>:
    8000178c:	ff010113          	addi	sp,sp,-16
    80001790:	00813423          	sd	s0,8(sp)
    80001794:	01010413          	addi	s0,sp,16
    80001798:	00813403          	ld	s0,8(sp)
    8000179c:	01010113          	addi	sp,sp,16
    800017a0:	00000317          	auipc	t1,0x0
    800017a4:	86030067          	jr	-1952(t1) # 80001000 <main>

00000000800017a8 <either_copyout>:
    800017a8:	ff010113          	addi	sp,sp,-16
    800017ac:	00813023          	sd	s0,0(sp)
    800017b0:	00113423          	sd	ra,8(sp)
    800017b4:	01010413          	addi	s0,sp,16
    800017b8:	02051663          	bnez	a0,800017e4 <either_copyout+0x3c>
    800017bc:	00058513          	mv	a0,a1
    800017c0:	00060593          	mv	a1,a2
    800017c4:	0006861b          	sext.w	a2,a3
    800017c8:	00002097          	auipc	ra,0x2
    800017cc:	c5c080e7          	jalr	-932(ra) # 80003424 <__memmove>
    800017d0:	00813083          	ld	ra,8(sp)
    800017d4:	00013403          	ld	s0,0(sp)
    800017d8:	00000513          	li	a0,0
    800017dc:	01010113          	addi	sp,sp,16
    800017e0:	00008067          	ret
    800017e4:	00003517          	auipc	a0,0x3
    800017e8:	8a450513          	addi	a0,a0,-1884 # 80004088 <_ZZ12printIntegermE6digits+0x68>
    800017ec:	00001097          	auipc	ra,0x1
    800017f0:	930080e7          	jalr	-1744(ra) # 8000211c <panic>

00000000800017f4 <either_copyin>:
    800017f4:	ff010113          	addi	sp,sp,-16
    800017f8:	00813023          	sd	s0,0(sp)
    800017fc:	00113423          	sd	ra,8(sp)
    80001800:	01010413          	addi	s0,sp,16
    80001804:	02059463          	bnez	a1,8000182c <either_copyin+0x38>
    80001808:	00060593          	mv	a1,a2
    8000180c:	0006861b          	sext.w	a2,a3
    80001810:	00002097          	auipc	ra,0x2
    80001814:	c14080e7          	jalr	-1004(ra) # 80003424 <__memmove>
    80001818:	00813083          	ld	ra,8(sp)
    8000181c:	00013403          	ld	s0,0(sp)
    80001820:	00000513          	li	a0,0
    80001824:	01010113          	addi	sp,sp,16
    80001828:	00008067          	ret
    8000182c:	00003517          	auipc	a0,0x3
    80001830:	88450513          	addi	a0,a0,-1916 # 800040b0 <_ZZ12printIntegermE6digits+0x90>
    80001834:	00001097          	auipc	ra,0x1
    80001838:	8e8080e7          	jalr	-1816(ra) # 8000211c <panic>

000000008000183c <trapinit>:
    8000183c:	ff010113          	addi	sp,sp,-16
    80001840:	00813423          	sd	s0,8(sp)
    80001844:	01010413          	addi	s0,sp,16
    80001848:	00813403          	ld	s0,8(sp)
    8000184c:	00003597          	auipc	a1,0x3
    80001850:	88c58593          	addi	a1,a1,-1908 # 800040d8 <_ZZ12printIntegermE6digits+0xb8>
    80001854:	00004517          	auipc	a0,0x4
    80001858:	c4c50513          	addi	a0,a0,-948 # 800054a0 <tickslock>
    8000185c:	01010113          	addi	sp,sp,16
    80001860:	00001317          	auipc	t1,0x1
    80001864:	5c830067          	jr	1480(t1) # 80002e28 <initlock>

0000000080001868 <trapinithart>:
    80001868:	ff010113          	addi	sp,sp,-16
    8000186c:	00813423          	sd	s0,8(sp)
    80001870:	01010413          	addi	s0,sp,16
    80001874:	00000797          	auipc	a5,0x0
    80001878:	2fc78793          	addi	a5,a5,764 # 80001b70 <kernelvec>
    8000187c:	10579073          	csrw	stvec,a5
    80001880:	00813403          	ld	s0,8(sp)
    80001884:	01010113          	addi	sp,sp,16
    80001888:	00008067          	ret

000000008000188c <usertrap>:
    8000188c:	ff010113          	addi	sp,sp,-16
    80001890:	00813423          	sd	s0,8(sp)
    80001894:	01010413          	addi	s0,sp,16
    80001898:	00813403          	ld	s0,8(sp)
    8000189c:	01010113          	addi	sp,sp,16
    800018a0:	00008067          	ret

00000000800018a4 <usertrapret>:
    800018a4:	ff010113          	addi	sp,sp,-16
    800018a8:	00813423          	sd	s0,8(sp)
    800018ac:	01010413          	addi	s0,sp,16
    800018b0:	00813403          	ld	s0,8(sp)
    800018b4:	01010113          	addi	sp,sp,16
    800018b8:	00008067          	ret

00000000800018bc <kerneltrap>:
    800018bc:	fe010113          	addi	sp,sp,-32
    800018c0:	00813823          	sd	s0,16(sp)
    800018c4:	00113c23          	sd	ra,24(sp)
    800018c8:	00913423          	sd	s1,8(sp)
    800018cc:	02010413          	addi	s0,sp,32
    800018d0:	142025f3          	csrr	a1,scause
    800018d4:	100027f3          	csrr	a5,sstatus
    800018d8:	0027f793          	andi	a5,a5,2
    800018dc:	10079c63          	bnez	a5,800019f4 <kerneltrap+0x138>
    800018e0:	142027f3          	csrr	a5,scause
    800018e4:	0207ce63          	bltz	a5,80001920 <kerneltrap+0x64>
    800018e8:	00003517          	auipc	a0,0x3
    800018ec:	83850513          	addi	a0,a0,-1992 # 80004120 <_ZZ12printIntegermE6digits+0x100>
    800018f0:	00001097          	auipc	ra,0x1
    800018f4:	888080e7          	jalr	-1912(ra) # 80002178 <__printf>
    800018f8:	141025f3          	csrr	a1,sepc
    800018fc:	14302673          	csrr	a2,stval
    80001900:	00003517          	auipc	a0,0x3
    80001904:	83050513          	addi	a0,a0,-2000 # 80004130 <_ZZ12printIntegermE6digits+0x110>
    80001908:	00001097          	auipc	ra,0x1
    8000190c:	870080e7          	jalr	-1936(ra) # 80002178 <__printf>
    80001910:	00003517          	auipc	a0,0x3
    80001914:	83850513          	addi	a0,a0,-1992 # 80004148 <_ZZ12printIntegermE6digits+0x128>
    80001918:	00001097          	auipc	ra,0x1
    8000191c:	804080e7          	jalr	-2044(ra) # 8000211c <panic>
    80001920:	0ff7f713          	andi	a4,a5,255
    80001924:	00900693          	li	a3,9
    80001928:	04d70063          	beq	a4,a3,80001968 <kerneltrap+0xac>
    8000192c:	fff00713          	li	a4,-1
    80001930:	03f71713          	slli	a4,a4,0x3f
    80001934:	00170713          	addi	a4,a4,1
    80001938:	fae798e3          	bne	a5,a4,800018e8 <kerneltrap+0x2c>
    8000193c:	00000097          	auipc	ra,0x0
    80001940:	e00080e7          	jalr	-512(ra) # 8000173c <cpuid>
    80001944:	06050663          	beqz	a0,800019b0 <kerneltrap+0xf4>
    80001948:	144027f3          	csrr	a5,sip
    8000194c:	ffd7f793          	andi	a5,a5,-3
    80001950:	14479073          	csrw	sip,a5
    80001954:	01813083          	ld	ra,24(sp)
    80001958:	01013403          	ld	s0,16(sp)
    8000195c:	00813483          	ld	s1,8(sp)
    80001960:	02010113          	addi	sp,sp,32
    80001964:	00008067          	ret
    80001968:	00000097          	auipc	ra,0x0
    8000196c:	3cc080e7          	jalr	972(ra) # 80001d34 <plic_claim>
    80001970:	00a00793          	li	a5,10
    80001974:	00050493          	mv	s1,a0
    80001978:	06f50863          	beq	a0,a5,800019e8 <kerneltrap+0x12c>
    8000197c:	fc050ce3          	beqz	a0,80001954 <kerneltrap+0x98>
    80001980:	00050593          	mv	a1,a0
    80001984:	00002517          	auipc	a0,0x2
    80001988:	77c50513          	addi	a0,a0,1916 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	7ec080e7          	jalr	2028(ra) # 80002178 <__printf>
    80001994:	01013403          	ld	s0,16(sp)
    80001998:	01813083          	ld	ra,24(sp)
    8000199c:	00048513          	mv	a0,s1
    800019a0:	00813483          	ld	s1,8(sp)
    800019a4:	02010113          	addi	sp,sp,32
    800019a8:	00000317          	auipc	t1,0x0
    800019ac:	3c430067          	jr	964(t1) # 80001d6c <plic_complete>
    800019b0:	00004517          	auipc	a0,0x4
    800019b4:	af050513          	addi	a0,a0,-1296 # 800054a0 <tickslock>
    800019b8:	00001097          	auipc	ra,0x1
    800019bc:	494080e7          	jalr	1172(ra) # 80002e4c <acquire>
    800019c0:	00003717          	auipc	a4,0x3
    800019c4:	9e470713          	addi	a4,a4,-1564 # 800043a4 <ticks>
    800019c8:	00072783          	lw	a5,0(a4)
    800019cc:	00004517          	auipc	a0,0x4
    800019d0:	ad450513          	addi	a0,a0,-1324 # 800054a0 <tickslock>
    800019d4:	0017879b          	addiw	a5,a5,1
    800019d8:	00f72023          	sw	a5,0(a4)
    800019dc:	00001097          	auipc	ra,0x1
    800019e0:	53c080e7          	jalr	1340(ra) # 80002f18 <release>
    800019e4:	f65ff06f          	j	80001948 <kerneltrap+0x8c>
    800019e8:	00001097          	auipc	ra,0x1
    800019ec:	098080e7          	jalr	152(ra) # 80002a80 <uartintr>
    800019f0:	fa5ff06f          	j	80001994 <kerneltrap+0xd8>
    800019f4:	00002517          	auipc	a0,0x2
    800019f8:	6ec50513          	addi	a0,a0,1772 # 800040e0 <_ZZ12printIntegermE6digits+0xc0>
    800019fc:	00000097          	auipc	ra,0x0
    80001a00:	720080e7          	jalr	1824(ra) # 8000211c <panic>

0000000080001a04 <clockintr>:
    80001a04:	fe010113          	addi	sp,sp,-32
    80001a08:	00813823          	sd	s0,16(sp)
    80001a0c:	00913423          	sd	s1,8(sp)
    80001a10:	00113c23          	sd	ra,24(sp)
    80001a14:	02010413          	addi	s0,sp,32
    80001a18:	00004497          	auipc	s1,0x4
    80001a1c:	a8848493          	addi	s1,s1,-1400 # 800054a0 <tickslock>
    80001a20:	00048513          	mv	a0,s1
    80001a24:	00001097          	auipc	ra,0x1
    80001a28:	428080e7          	jalr	1064(ra) # 80002e4c <acquire>
    80001a2c:	00003717          	auipc	a4,0x3
    80001a30:	97870713          	addi	a4,a4,-1672 # 800043a4 <ticks>
    80001a34:	00072783          	lw	a5,0(a4)
    80001a38:	01013403          	ld	s0,16(sp)
    80001a3c:	01813083          	ld	ra,24(sp)
    80001a40:	00048513          	mv	a0,s1
    80001a44:	0017879b          	addiw	a5,a5,1
    80001a48:	00813483          	ld	s1,8(sp)
    80001a4c:	00f72023          	sw	a5,0(a4)
    80001a50:	02010113          	addi	sp,sp,32
    80001a54:	00001317          	auipc	t1,0x1
    80001a58:	4c430067          	jr	1220(t1) # 80002f18 <release>

0000000080001a5c <devintr>:
    80001a5c:	142027f3          	csrr	a5,scause
    80001a60:	00000513          	li	a0,0
    80001a64:	0007c463          	bltz	a5,80001a6c <devintr+0x10>
    80001a68:	00008067          	ret
    80001a6c:	fe010113          	addi	sp,sp,-32
    80001a70:	00813823          	sd	s0,16(sp)
    80001a74:	00113c23          	sd	ra,24(sp)
    80001a78:	00913423          	sd	s1,8(sp)
    80001a7c:	02010413          	addi	s0,sp,32
    80001a80:	0ff7f713          	andi	a4,a5,255
    80001a84:	00900693          	li	a3,9
    80001a88:	04d70c63          	beq	a4,a3,80001ae0 <devintr+0x84>
    80001a8c:	fff00713          	li	a4,-1
    80001a90:	03f71713          	slli	a4,a4,0x3f
    80001a94:	00170713          	addi	a4,a4,1
    80001a98:	00e78c63          	beq	a5,a4,80001ab0 <devintr+0x54>
    80001a9c:	01813083          	ld	ra,24(sp)
    80001aa0:	01013403          	ld	s0,16(sp)
    80001aa4:	00813483          	ld	s1,8(sp)
    80001aa8:	02010113          	addi	sp,sp,32
    80001aac:	00008067          	ret
    80001ab0:	00000097          	auipc	ra,0x0
    80001ab4:	c8c080e7          	jalr	-884(ra) # 8000173c <cpuid>
    80001ab8:	06050663          	beqz	a0,80001b24 <devintr+0xc8>
    80001abc:	144027f3          	csrr	a5,sip
    80001ac0:	ffd7f793          	andi	a5,a5,-3
    80001ac4:	14479073          	csrw	sip,a5
    80001ac8:	01813083          	ld	ra,24(sp)
    80001acc:	01013403          	ld	s0,16(sp)
    80001ad0:	00813483          	ld	s1,8(sp)
    80001ad4:	00200513          	li	a0,2
    80001ad8:	02010113          	addi	sp,sp,32
    80001adc:	00008067          	ret
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	254080e7          	jalr	596(ra) # 80001d34 <plic_claim>
    80001ae8:	00a00793          	li	a5,10
    80001aec:	00050493          	mv	s1,a0
    80001af0:	06f50663          	beq	a0,a5,80001b5c <devintr+0x100>
    80001af4:	00100513          	li	a0,1
    80001af8:	fa0482e3          	beqz	s1,80001a9c <devintr+0x40>
    80001afc:	00048593          	mv	a1,s1
    80001b00:	00002517          	auipc	a0,0x2
    80001b04:	60050513          	addi	a0,a0,1536 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    80001b08:	00000097          	auipc	ra,0x0
    80001b0c:	670080e7          	jalr	1648(ra) # 80002178 <__printf>
    80001b10:	00048513          	mv	a0,s1
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	258080e7          	jalr	600(ra) # 80001d6c <plic_complete>
    80001b1c:	00100513          	li	a0,1
    80001b20:	f7dff06f          	j	80001a9c <devintr+0x40>
    80001b24:	00004517          	auipc	a0,0x4
    80001b28:	97c50513          	addi	a0,a0,-1668 # 800054a0 <tickslock>
    80001b2c:	00001097          	auipc	ra,0x1
    80001b30:	320080e7          	jalr	800(ra) # 80002e4c <acquire>
    80001b34:	00003717          	auipc	a4,0x3
    80001b38:	87070713          	addi	a4,a4,-1936 # 800043a4 <ticks>
    80001b3c:	00072783          	lw	a5,0(a4)
    80001b40:	00004517          	auipc	a0,0x4
    80001b44:	96050513          	addi	a0,a0,-1696 # 800054a0 <tickslock>
    80001b48:	0017879b          	addiw	a5,a5,1
    80001b4c:	00f72023          	sw	a5,0(a4)
    80001b50:	00001097          	auipc	ra,0x1
    80001b54:	3c8080e7          	jalr	968(ra) # 80002f18 <release>
    80001b58:	f65ff06f          	j	80001abc <devintr+0x60>
    80001b5c:	00001097          	auipc	ra,0x1
    80001b60:	f24080e7          	jalr	-220(ra) # 80002a80 <uartintr>
    80001b64:	fadff06f          	j	80001b10 <devintr+0xb4>
	...

0000000080001b70 <kernelvec>:
    80001b70:	f0010113          	addi	sp,sp,-256
    80001b74:	00113023          	sd	ra,0(sp)
    80001b78:	00213423          	sd	sp,8(sp)
    80001b7c:	00313823          	sd	gp,16(sp)
    80001b80:	00413c23          	sd	tp,24(sp)
    80001b84:	02513023          	sd	t0,32(sp)
    80001b88:	02613423          	sd	t1,40(sp)
    80001b8c:	02713823          	sd	t2,48(sp)
    80001b90:	02813c23          	sd	s0,56(sp)
    80001b94:	04913023          	sd	s1,64(sp)
    80001b98:	04a13423          	sd	a0,72(sp)
    80001b9c:	04b13823          	sd	a1,80(sp)
    80001ba0:	04c13c23          	sd	a2,88(sp)
    80001ba4:	06d13023          	sd	a3,96(sp)
    80001ba8:	06e13423          	sd	a4,104(sp)
    80001bac:	06f13823          	sd	a5,112(sp)
    80001bb0:	07013c23          	sd	a6,120(sp)
    80001bb4:	09113023          	sd	a7,128(sp)
    80001bb8:	09213423          	sd	s2,136(sp)
    80001bbc:	09313823          	sd	s3,144(sp)
    80001bc0:	09413c23          	sd	s4,152(sp)
    80001bc4:	0b513023          	sd	s5,160(sp)
    80001bc8:	0b613423          	sd	s6,168(sp)
    80001bcc:	0b713823          	sd	s7,176(sp)
    80001bd0:	0b813c23          	sd	s8,184(sp)
    80001bd4:	0d913023          	sd	s9,192(sp)
    80001bd8:	0da13423          	sd	s10,200(sp)
    80001bdc:	0db13823          	sd	s11,208(sp)
    80001be0:	0dc13c23          	sd	t3,216(sp)
    80001be4:	0fd13023          	sd	t4,224(sp)
    80001be8:	0fe13423          	sd	t5,232(sp)
    80001bec:	0ff13823          	sd	t6,240(sp)
    80001bf0:	ccdff0ef          	jal	ra,800018bc <kerneltrap>
    80001bf4:	00013083          	ld	ra,0(sp)
    80001bf8:	00813103          	ld	sp,8(sp)
    80001bfc:	01013183          	ld	gp,16(sp)
    80001c00:	02013283          	ld	t0,32(sp)
    80001c04:	02813303          	ld	t1,40(sp)
    80001c08:	03013383          	ld	t2,48(sp)
    80001c0c:	03813403          	ld	s0,56(sp)
    80001c10:	04013483          	ld	s1,64(sp)
    80001c14:	04813503          	ld	a0,72(sp)
    80001c18:	05013583          	ld	a1,80(sp)
    80001c1c:	05813603          	ld	a2,88(sp)
    80001c20:	06013683          	ld	a3,96(sp)
    80001c24:	06813703          	ld	a4,104(sp)
    80001c28:	07013783          	ld	a5,112(sp)
    80001c2c:	07813803          	ld	a6,120(sp)
    80001c30:	08013883          	ld	a7,128(sp)
    80001c34:	08813903          	ld	s2,136(sp)
    80001c38:	09013983          	ld	s3,144(sp)
    80001c3c:	09813a03          	ld	s4,152(sp)
    80001c40:	0a013a83          	ld	s5,160(sp)
    80001c44:	0a813b03          	ld	s6,168(sp)
    80001c48:	0b013b83          	ld	s7,176(sp)
    80001c4c:	0b813c03          	ld	s8,184(sp)
    80001c50:	0c013c83          	ld	s9,192(sp)
    80001c54:	0c813d03          	ld	s10,200(sp)
    80001c58:	0d013d83          	ld	s11,208(sp)
    80001c5c:	0d813e03          	ld	t3,216(sp)
    80001c60:	0e013e83          	ld	t4,224(sp)
    80001c64:	0e813f03          	ld	t5,232(sp)
    80001c68:	0f013f83          	ld	t6,240(sp)
    80001c6c:	10010113          	addi	sp,sp,256
    80001c70:	10200073          	sret
    80001c74:	00000013          	nop
    80001c78:	00000013          	nop
    80001c7c:	00000013          	nop

0000000080001c80 <timervec>:
    80001c80:	34051573          	csrrw	a0,mscratch,a0
    80001c84:	00b53023          	sd	a1,0(a0)
    80001c88:	00c53423          	sd	a2,8(a0)
    80001c8c:	00d53823          	sd	a3,16(a0)
    80001c90:	01853583          	ld	a1,24(a0)
    80001c94:	02053603          	ld	a2,32(a0)
    80001c98:	0005b683          	ld	a3,0(a1)
    80001c9c:	00c686b3          	add	a3,a3,a2
    80001ca0:	00d5b023          	sd	a3,0(a1)
    80001ca4:	00200593          	li	a1,2
    80001ca8:	14459073          	csrw	sip,a1
    80001cac:	01053683          	ld	a3,16(a0)
    80001cb0:	00853603          	ld	a2,8(a0)
    80001cb4:	00053583          	ld	a1,0(a0)
    80001cb8:	34051573          	csrrw	a0,mscratch,a0
    80001cbc:	30200073          	mret

0000000080001cc0 <plicinit>:
    80001cc0:	ff010113          	addi	sp,sp,-16
    80001cc4:	00813423          	sd	s0,8(sp)
    80001cc8:	01010413          	addi	s0,sp,16
    80001ccc:	00813403          	ld	s0,8(sp)
    80001cd0:	0c0007b7          	lui	a5,0xc000
    80001cd4:	00100713          	li	a4,1
    80001cd8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001cdc:	00e7a223          	sw	a4,4(a5)
    80001ce0:	01010113          	addi	sp,sp,16
    80001ce4:	00008067          	ret

0000000080001ce8 <plicinithart>:
    80001ce8:	ff010113          	addi	sp,sp,-16
    80001cec:	00813023          	sd	s0,0(sp)
    80001cf0:	00113423          	sd	ra,8(sp)
    80001cf4:	01010413          	addi	s0,sp,16
    80001cf8:	00000097          	auipc	ra,0x0
    80001cfc:	a44080e7          	jalr	-1468(ra) # 8000173c <cpuid>
    80001d00:	0085171b          	slliw	a4,a0,0x8
    80001d04:	0c0027b7          	lui	a5,0xc002
    80001d08:	00e787b3          	add	a5,a5,a4
    80001d0c:	40200713          	li	a4,1026
    80001d10:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001d14:	00813083          	ld	ra,8(sp)
    80001d18:	00013403          	ld	s0,0(sp)
    80001d1c:	00d5151b          	slliw	a0,a0,0xd
    80001d20:	0c2017b7          	lui	a5,0xc201
    80001d24:	00a78533          	add	a0,a5,a0
    80001d28:	00052023          	sw	zero,0(a0)
    80001d2c:	01010113          	addi	sp,sp,16
    80001d30:	00008067          	ret

0000000080001d34 <plic_claim>:
    80001d34:	ff010113          	addi	sp,sp,-16
    80001d38:	00813023          	sd	s0,0(sp)
    80001d3c:	00113423          	sd	ra,8(sp)
    80001d40:	01010413          	addi	s0,sp,16
    80001d44:	00000097          	auipc	ra,0x0
    80001d48:	9f8080e7          	jalr	-1544(ra) # 8000173c <cpuid>
    80001d4c:	00813083          	ld	ra,8(sp)
    80001d50:	00013403          	ld	s0,0(sp)
    80001d54:	00d5151b          	slliw	a0,a0,0xd
    80001d58:	0c2017b7          	lui	a5,0xc201
    80001d5c:	00a78533          	add	a0,a5,a0
    80001d60:	00452503          	lw	a0,4(a0)
    80001d64:	01010113          	addi	sp,sp,16
    80001d68:	00008067          	ret

0000000080001d6c <plic_complete>:
    80001d6c:	fe010113          	addi	sp,sp,-32
    80001d70:	00813823          	sd	s0,16(sp)
    80001d74:	00913423          	sd	s1,8(sp)
    80001d78:	00113c23          	sd	ra,24(sp)
    80001d7c:	02010413          	addi	s0,sp,32
    80001d80:	00050493          	mv	s1,a0
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	9b8080e7          	jalr	-1608(ra) # 8000173c <cpuid>
    80001d8c:	01813083          	ld	ra,24(sp)
    80001d90:	01013403          	ld	s0,16(sp)
    80001d94:	00d5179b          	slliw	a5,a0,0xd
    80001d98:	0c201737          	lui	a4,0xc201
    80001d9c:	00f707b3          	add	a5,a4,a5
    80001da0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001da4:	00813483          	ld	s1,8(sp)
    80001da8:	02010113          	addi	sp,sp,32
    80001dac:	00008067          	ret

0000000080001db0 <consolewrite>:
    80001db0:	fb010113          	addi	sp,sp,-80
    80001db4:	04813023          	sd	s0,64(sp)
    80001db8:	04113423          	sd	ra,72(sp)
    80001dbc:	02913c23          	sd	s1,56(sp)
    80001dc0:	03213823          	sd	s2,48(sp)
    80001dc4:	03313423          	sd	s3,40(sp)
    80001dc8:	03413023          	sd	s4,32(sp)
    80001dcc:	01513c23          	sd	s5,24(sp)
    80001dd0:	05010413          	addi	s0,sp,80
    80001dd4:	06c05c63          	blez	a2,80001e4c <consolewrite+0x9c>
    80001dd8:	00060993          	mv	s3,a2
    80001ddc:	00050a13          	mv	s4,a0
    80001de0:	00058493          	mv	s1,a1
    80001de4:	00000913          	li	s2,0
    80001de8:	fff00a93          	li	s5,-1
    80001dec:	01c0006f          	j	80001e08 <consolewrite+0x58>
    80001df0:	fbf44503          	lbu	a0,-65(s0)
    80001df4:	0019091b          	addiw	s2,s2,1
    80001df8:	00148493          	addi	s1,s1,1
    80001dfc:	00001097          	auipc	ra,0x1
    80001e00:	a9c080e7          	jalr	-1380(ra) # 80002898 <uartputc>
    80001e04:	03298063          	beq	s3,s2,80001e24 <consolewrite+0x74>
    80001e08:	00048613          	mv	a2,s1
    80001e0c:	00100693          	li	a3,1
    80001e10:	000a0593          	mv	a1,s4
    80001e14:	fbf40513          	addi	a0,s0,-65
    80001e18:	00000097          	auipc	ra,0x0
    80001e1c:	9dc080e7          	jalr	-1572(ra) # 800017f4 <either_copyin>
    80001e20:	fd5518e3          	bne	a0,s5,80001df0 <consolewrite+0x40>
    80001e24:	04813083          	ld	ra,72(sp)
    80001e28:	04013403          	ld	s0,64(sp)
    80001e2c:	03813483          	ld	s1,56(sp)
    80001e30:	02813983          	ld	s3,40(sp)
    80001e34:	02013a03          	ld	s4,32(sp)
    80001e38:	01813a83          	ld	s5,24(sp)
    80001e3c:	00090513          	mv	a0,s2
    80001e40:	03013903          	ld	s2,48(sp)
    80001e44:	05010113          	addi	sp,sp,80
    80001e48:	00008067          	ret
    80001e4c:	00000913          	li	s2,0
    80001e50:	fd5ff06f          	j	80001e24 <consolewrite+0x74>

0000000080001e54 <consoleread>:
    80001e54:	f9010113          	addi	sp,sp,-112
    80001e58:	06813023          	sd	s0,96(sp)
    80001e5c:	04913c23          	sd	s1,88(sp)
    80001e60:	05213823          	sd	s2,80(sp)
    80001e64:	05313423          	sd	s3,72(sp)
    80001e68:	05413023          	sd	s4,64(sp)
    80001e6c:	03513c23          	sd	s5,56(sp)
    80001e70:	03613823          	sd	s6,48(sp)
    80001e74:	03713423          	sd	s7,40(sp)
    80001e78:	03813023          	sd	s8,32(sp)
    80001e7c:	06113423          	sd	ra,104(sp)
    80001e80:	01913c23          	sd	s9,24(sp)
    80001e84:	07010413          	addi	s0,sp,112
    80001e88:	00060b93          	mv	s7,a2
    80001e8c:	00050913          	mv	s2,a0
    80001e90:	00058c13          	mv	s8,a1
    80001e94:	00060b1b          	sext.w	s6,a2
    80001e98:	00003497          	auipc	s1,0x3
    80001e9c:	62048493          	addi	s1,s1,1568 # 800054b8 <cons>
    80001ea0:	00400993          	li	s3,4
    80001ea4:	fff00a13          	li	s4,-1
    80001ea8:	00a00a93          	li	s5,10
    80001eac:	05705e63          	blez	s7,80001f08 <consoleread+0xb4>
    80001eb0:	09c4a703          	lw	a4,156(s1)
    80001eb4:	0984a783          	lw	a5,152(s1)
    80001eb8:	0007071b          	sext.w	a4,a4
    80001ebc:	08e78463          	beq	a5,a4,80001f44 <consoleread+0xf0>
    80001ec0:	07f7f713          	andi	a4,a5,127
    80001ec4:	00e48733          	add	a4,s1,a4
    80001ec8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001ecc:	0017869b          	addiw	a3,a5,1
    80001ed0:	08d4ac23          	sw	a3,152(s1)
    80001ed4:	00070c9b          	sext.w	s9,a4
    80001ed8:	0b370663          	beq	a4,s3,80001f84 <consoleread+0x130>
    80001edc:	00100693          	li	a3,1
    80001ee0:	f9f40613          	addi	a2,s0,-97
    80001ee4:	000c0593          	mv	a1,s8
    80001ee8:	00090513          	mv	a0,s2
    80001eec:	f8e40fa3          	sb	a4,-97(s0)
    80001ef0:	00000097          	auipc	ra,0x0
    80001ef4:	8b8080e7          	jalr	-1864(ra) # 800017a8 <either_copyout>
    80001ef8:	01450863          	beq	a0,s4,80001f08 <consoleread+0xb4>
    80001efc:	001c0c13          	addi	s8,s8,1
    80001f00:	fffb8b9b          	addiw	s7,s7,-1
    80001f04:	fb5c94e3          	bne	s9,s5,80001eac <consoleread+0x58>
    80001f08:	000b851b          	sext.w	a0,s7
    80001f0c:	06813083          	ld	ra,104(sp)
    80001f10:	06013403          	ld	s0,96(sp)
    80001f14:	05813483          	ld	s1,88(sp)
    80001f18:	05013903          	ld	s2,80(sp)
    80001f1c:	04813983          	ld	s3,72(sp)
    80001f20:	04013a03          	ld	s4,64(sp)
    80001f24:	03813a83          	ld	s5,56(sp)
    80001f28:	02813b83          	ld	s7,40(sp)
    80001f2c:	02013c03          	ld	s8,32(sp)
    80001f30:	01813c83          	ld	s9,24(sp)
    80001f34:	40ab053b          	subw	a0,s6,a0
    80001f38:	03013b03          	ld	s6,48(sp)
    80001f3c:	07010113          	addi	sp,sp,112
    80001f40:	00008067          	ret
    80001f44:	00001097          	auipc	ra,0x1
    80001f48:	1d8080e7          	jalr	472(ra) # 8000311c <push_on>
    80001f4c:	0984a703          	lw	a4,152(s1)
    80001f50:	09c4a783          	lw	a5,156(s1)
    80001f54:	0007879b          	sext.w	a5,a5
    80001f58:	fef70ce3          	beq	a4,a5,80001f50 <consoleread+0xfc>
    80001f5c:	00001097          	auipc	ra,0x1
    80001f60:	234080e7          	jalr	564(ra) # 80003190 <pop_on>
    80001f64:	0984a783          	lw	a5,152(s1)
    80001f68:	07f7f713          	andi	a4,a5,127
    80001f6c:	00e48733          	add	a4,s1,a4
    80001f70:	01874703          	lbu	a4,24(a4)
    80001f74:	0017869b          	addiw	a3,a5,1
    80001f78:	08d4ac23          	sw	a3,152(s1)
    80001f7c:	00070c9b          	sext.w	s9,a4
    80001f80:	f5371ee3          	bne	a4,s3,80001edc <consoleread+0x88>
    80001f84:	000b851b          	sext.w	a0,s7
    80001f88:	f96bf2e3          	bgeu	s7,s6,80001f0c <consoleread+0xb8>
    80001f8c:	08f4ac23          	sw	a5,152(s1)
    80001f90:	f7dff06f          	j	80001f0c <consoleread+0xb8>

0000000080001f94 <consputc>:
    80001f94:	10000793          	li	a5,256
    80001f98:	00f50663          	beq	a0,a5,80001fa4 <consputc+0x10>
    80001f9c:	00001317          	auipc	t1,0x1
    80001fa0:	9f430067          	jr	-1548(t1) # 80002990 <uartputc_sync>
    80001fa4:	ff010113          	addi	sp,sp,-16
    80001fa8:	00113423          	sd	ra,8(sp)
    80001fac:	00813023          	sd	s0,0(sp)
    80001fb0:	01010413          	addi	s0,sp,16
    80001fb4:	00800513          	li	a0,8
    80001fb8:	00001097          	auipc	ra,0x1
    80001fbc:	9d8080e7          	jalr	-1576(ra) # 80002990 <uartputc_sync>
    80001fc0:	02000513          	li	a0,32
    80001fc4:	00001097          	auipc	ra,0x1
    80001fc8:	9cc080e7          	jalr	-1588(ra) # 80002990 <uartputc_sync>
    80001fcc:	00013403          	ld	s0,0(sp)
    80001fd0:	00813083          	ld	ra,8(sp)
    80001fd4:	00800513          	li	a0,8
    80001fd8:	01010113          	addi	sp,sp,16
    80001fdc:	00001317          	auipc	t1,0x1
    80001fe0:	9b430067          	jr	-1612(t1) # 80002990 <uartputc_sync>

0000000080001fe4 <consoleintr>:
    80001fe4:	fe010113          	addi	sp,sp,-32
    80001fe8:	00813823          	sd	s0,16(sp)
    80001fec:	00913423          	sd	s1,8(sp)
    80001ff0:	01213023          	sd	s2,0(sp)
    80001ff4:	00113c23          	sd	ra,24(sp)
    80001ff8:	02010413          	addi	s0,sp,32
    80001ffc:	00003917          	auipc	s2,0x3
    80002000:	4bc90913          	addi	s2,s2,1212 # 800054b8 <cons>
    80002004:	00050493          	mv	s1,a0
    80002008:	00090513          	mv	a0,s2
    8000200c:	00001097          	auipc	ra,0x1
    80002010:	e40080e7          	jalr	-448(ra) # 80002e4c <acquire>
    80002014:	02048c63          	beqz	s1,8000204c <consoleintr+0x68>
    80002018:	0a092783          	lw	a5,160(s2)
    8000201c:	09892703          	lw	a4,152(s2)
    80002020:	07f00693          	li	a3,127
    80002024:	40e7873b          	subw	a4,a5,a4
    80002028:	02e6e263          	bltu	a3,a4,8000204c <consoleintr+0x68>
    8000202c:	00d00713          	li	a4,13
    80002030:	04e48063          	beq	s1,a4,80002070 <consoleintr+0x8c>
    80002034:	07f7f713          	andi	a4,a5,127
    80002038:	00e90733          	add	a4,s2,a4
    8000203c:	0017879b          	addiw	a5,a5,1
    80002040:	0af92023          	sw	a5,160(s2)
    80002044:	00970c23          	sb	s1,24(a4)
    80002048:	08f92e23          	sw	a5,156(s2)
    8000204c:	01013403          	ld	s0,16(sp)
    80002050:	01813083          	ld	ra,24(sp)
    80002054:	00813483          	ld	s1,8(sp)
    80002058:	00013903          	ld	s2,0(sp)
    8000205c:	00003517          	auipc	a0,0x3
    80002060:	45c50513          	addi	a0,a0,1116 # 800054b8 <cons>
    80002064:	02010113          	addi	sp,sp,32
    80002068:	00001317          	auipc	t1,0x1
    8000206c:	eb030067          	jr	-336(t1) # 80002f18 <release>
    80002070:	00a00493          	li	s1,10
    80002074:	fc1ff06f          	j	80002034 <consoleintr+0x50>

0000000080002078 <consoleinit>:
    80002078:	fe010113          	addi	sp,sp,-32
    8000207c:	00113c23          	sd	ra,24(sp)
    80002080:	00813823          	sd	s0,16(sp)
    80002084:	00913423          	sd	s1,8(sp)
    80002088:	02010413          	addi	s0,sp,32
    8000208c:	00003497          	auipc	s1,0x3
    80002090:	42c48493          	addi	s1,s1,1068 # 800054b8 <cons>
    80002094:	00048513          	mv	a0,s1
    80002098:	00002597          	auipc	a1,0x2
    8000209c:	0c058593          	addi	a1,a1,192 # 80004158 <_ZZ12printIntegermE6digits+0x138>
    800020a0:	00001097          	auipc	ra,0x1
    800020a4:	d88080e7          	jalr	-632(ra) # 80002e28 <initlock>
    800020a8:	00000097          	auipc	ra,0x0
    800020ac:	7ac080e7          	jalr	1964(ra) # 80002854 <uartinit>
    800020b0:	01813083          	ld	ra,24(sp)
    800020b4:	01013403          	ld	s0,16(sp)
    800020b8:	00000797          	auipc	a5,0x0
    800020bc:	d9c78793          	addi	a5,a5,-612 # 80001e54 <consoleread>
    800020c0:	0af4bc23          	sd	a5,184(s1)
    800020c4:	00000797          	auipc	a5,0x0
    800020c8:	cec78793          	addi	a5,a5,-788 # 80001db0 <consolewrite>
    800020cc:	0cf4b023          	sd	a5,192(s1)
    800020d0:	00813483          	ld	s1,8(sp)
    800020d4:	02010113          	addi	sp,sp,32
    800020d8:	00008067          	ret

00000000800020dc <console_read>:
    800020dc:	ff010113          	addi	sp,sp,-16
    800020e0:	00813423          	sd	s0,8(sp)
    800020e4:	01010413          	addi	s0,sp,16
    800020e8:	00813403          	ld	s0,8(sp)
    800020ec:	00003317          	auipc	t1,0x3
    800020f0:	48433303          	ld	t1,1156(t1) # 80005570 <devsw+0x10>
    800020f4:	01010113          	addi	sp,sp,16
    800020f8:	00030067          	jr	t1

00000000800020fc <console_write>:
    800020fc:	ff010113          	addi	sp,sp,-16
    80002100:	00813423          	sd	s0,8(sp)
    80002104:	01010413          	addi	s0,sp,16
    80002108:	00813403          	ld	s0,8(sp)
    8000210c:	00003317          	auipc	t1,0x3
    80002110:	46c33303          	ld	t1,1132(t1) # 80005578 <devsw+0x18>
    80002114:	01010113          	addi	sp,sp,16
    80002118:	00030067          	jr	t1

000000008000211c <panic>:
    8000211c:	fe010113          	addi	sp,sp,-32
    80002120:	00113c23          	sd	ra,24(sp)
    80002124:	00813823          	sd	s0,16(sp)
    80002128:	00913423          	sd	s1,8(sp)
    8000212c:	02010413          	addi	s0,sp,32
    80002130:	00050493          	mv	s1,a0
    80002134:	00002517          	auipc	a0,0x2
    80002138:	02c50513          	addi	a0,a0,44 # 80004160 <_ZZ12printIntegermE6digits+0x140>
    8000213c:	00003797          	auipc	a5,0x3
    80002140:	4c07ae23          	sw	zero,1244(a5) # 80005618 <pr+0x18>
    80002144:	00000097          	auipc	ra,0x0
    80002148:	034080e7          	jalr	52(ra) # 80002178 <__printf>
    8000214c:	00048513          	mv	a0,s1
    80002150:	00000097          	auipc	ra,0x0
    80002154:	028080e7          	jalr	40(ra) # 80002178 <__printf>
    80002158:	00002517          	auipc	a0,0x2
    8000215c:	fe850513          	addi	a0,a0,-24 # 80004140 <_ZZ12printIntegermE6digits+0x120>
    80002160:	00000097          	auipc	ra,0x0
    80002164:	018080e7          	jalr	24(ra) # 80002178 <__printf>
    80002168:	00100793          	li	a5,1
    8000216c:	00002717          	auipc	a4,0x2
    80002170:	22f72e23          	sw	a5,572(a4) # 800043a8 <panicked>
    80002174:	0000006f          	j	80002174 <panic+0x58>

0000000080002178 <__printf>:
    80002178:	f3010113          	addi	sp,sp,-208
    8000217c:	08813023          	sd	s0,128(sp)
    80002180:	07313423          	sd	s3,104(sp)
    80002184:	09010413          	addi	s0,sp,144
    80002188:	05813023          	sd	s8,64(sp)
    8000218c:	08113423          	sd	ra,136(sp)
    80002190:	06913c23          	sd	s1,120(sp)
    80002194:	07213823          	sd	s2,112(sp)
    80002198:	07413023          	sd	s4,96(sp)
    8000219c:	05513c23          	sd	s5,88(sp)
    800021a0:	05613823          	sd	s6,80(sp)
    800021a4:	05713423          	sd	s7,72(sp)
    800021a8:	03913c23          	sd	s9,56(sp)
    800021ac:	03a13823          	sd	s10,48(sp)
    800021b0:	03b13423          	sd	s11,40(sp)
    800021b4:	00003317          	auipc	t1,0x3
    800021b8:	44c30313          	addi	t1,t1,1100 # 80005600 <pr>
    800021bc:	01832c03          	lw	s8,24(t1)
    800021c0:	00b43423          	sd	a1,8(s0)
    800021c4:	00c43823          	sd	a2,16(s0)
    800021c8:	00d43c23          	sd	a3,24(s0)
    800021cc:	02e43023          	sd	a4,32(s0)
    800021d0:	02f43423          	sd	a5,40(s0)
    800021d4:	03043823          	sd	a6,48(s0)
    800021d8:	03143c23          	sd	a7,56(s0)
    800021dc:	00050993          	mv	s3,a0
    800021e0:	4a0c1663          	bnez	s8,8000268c <__printf+0x514>
    800021e4:	60098c63          	beqz	s3,800027fc <__printf+0x684>
    800021e8:	0009c503          	lbu	a0,0(s3)
    800021ec:	00840793          	addi	a5,s0,8
    800021f0:	f6f43c23          	sd	a5,-136(s0)
    800021f4:	00000493          	li	s1,0
    800021f8:	22050063          	beqz	a0,80002418 <__printf+0x2a0>
    800021fc:	00002a37          	lui	s4,0x2
    80002200:	00018ab7          	lui	s5,0x18
    80002204:	000f4b37          	lui	s6,0xf4
    80002208:	00989bb7          	lui	s7,0x989
    8000220c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002210:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002214:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002218:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000221c:	00148c9b          	addiw	s9,s1,1
    80002220:	02500793          	li	a5,37
    80002224:	01998933          	add	s2,s3,s9
    80002228:	38f51263          	bne	a0,a5,800025ac <__printf+0x434>
    8000222c:	00094783          	lbu	a5,0(s2)
    80002230:	00078c9b          	sext.w	s9,a5
    80002234:	1e078263          	beqz	a5,80002418 <__printf+0x2a0>
    80002238:	0024849b          	addiw	s1,s1,2
    8000223c:	07000713          	li	a4,112
    80002240:	00998933          	add	s2,s3,s1
    80002244:	38e78a63          	beq	a5,a4,800025d8 <__printf+0x460>
    80002248:	20f76863          	bltu	a4,a5,80002458 <__printf+0x2e0>
    8000224c:	42a78863          	beq	a5,a0,8000267c <__printf+0x504>
    80002250:	06400713          	li	a4,100
    80002254:	40e79663          	bne	a5,a4,80002660 <__printf+0x4e8>
    80002258:	f7843783          	ld	a5,-136(s0)
    8000225c:	0007a603          	lw	a2,0(a5)
    80002260:	00878793          	addi	a5,a5,8
    80002264:	f6f43c23          	sd	a5,-136(s0)
    80002268:	42064a63          	bltz	a2,8000269c <__printf+0x524>
    8000226c:	00a00713          	li	a4,10
    80002270:	02e677bb          	remuw	a5,a2,a4
    80002274:	00002d97          	auipc	s11,0x2
    80002278:	f14d8d93          	addi	s11,s11,-236 # 80004188 <digits>
    8000227c:	00900593          	li	a1,9
    80002280:	0006051b          	sext.w	a0,a2
    80002284:	00000c93          	li	s9,0
    80002288:	02079793          	slli	a5,a5,0x20
    8000228c:	0207d793          	srli	a5,a5,0x20
    80002290:	00fd87b3          	add	a5,s11,a5
    80002294:	0007c783          	lbu	a5,0(a5)
    80002298:	02e656bb          	divuw	a3,a2,a4
    8000229c:	f8f40023          	sb	a5,-128(s0)
    800022a0:	14c5d863          	bge	a1,a2,800023f0 <__printf+0x278>
    800022a4:	06300593          	li	a1,99
    800022a8:	00100c93          	li	s9,1
    800022ac:	02e6f7bb          	remuw	a5,a3,a4
    800022b0:	02079793          	slli	a5,a5,0x20
    800022b4:	0207d793          	srli	a5,a5,0x20
    800022b8:	00fd87b3          	add	a5,s11,a5
    800022bc:	0007c783          	lbu	a5,0(a5)
    800022c0:	02e6d73b          	divuw	a4,a3,a4
    800022c4:	f8f400a3          	sb	a5,-127(s0)
    800022c8:	12a5f463          	bgeu	a1,a0,800023f0 <__printf+0x278>
    800022cc:	00a00693          	li	a3,10
    800022d0:	00900593          	li	a1,9
    800022d4:	02d777bb          	remuw	a5,a4,a3
    800022d8:	02079793          	slli	a5,a5,0x20
    800022dc:	0207d793          	srli	a5,a5,0x20
    800022e0:	00fd87b3          	add	a5,s11,a5
    800022e4:	0007c503          	lbu	a0,0(a5)
    800022e8:	02d757bb          	divuw	a5,a4,a3
    800022ec:	f8a40123          	sb	a0,-126(s0)
    800022f0:	48e5f263          	bgeu	a1,a4,80002774 <__printf+0x5fc>
    800022f4:	06300513          	li	a0,99
    800022f8:	02d7f5bb          	remuw	a1,a5,a3
    800022fc:	02059593          	slli	a1,a1,0x20
    80002300:	0205d593          	srli	a1,a1,0x20
    80002304:	00bd85b3          	add	a1,s11,a1
    80002308:	0005c583          	lbu	a1,0(a1)
    8000230c:	02d7d7bb          	divuw	a5,a5,a3
    80002310:	f8b401a3          	sb	a1,-125(s0)
    80002314:	48e57263          	bgeu	a0,a4,80002798 <__printf+0x620>
    80002318:	3e700513          	li	a0,999
    8000231c:	02d7f5bb          	remuw	a1,a5,a3
    80002320:	02059593          	slli	a1,a1,0x20
    80002324:	0205d593          	srli	a1,a1,0x20
    80002328:	00bd85b3          	add	a1,s11,a1
    8000232c:	0005c583          	lbu	a1,0(a1)
    80002330:	02d7d7bb          	divuw	a5,a5,a3
    80002334:	f8b40223          	sb	a1,-124(s0)
    80002338:	46e57663          	bgeu	a0,a4,800027a4 <__printf+0x62c>
    8000233c:	02d7f5bb          	remuw	a1,a5,a3
    80002340:	02059593          	slli	a1,a1,0x20
    80002344:	0205d593          	srli	a1,a1,0x20
    80002348:	00bd85b3          	add	a1,s11,a1
    8000234c:	0005c583          	lbu	a1,0(a1)
    80002350:	02d7d7bb          	divuw	a5,a5,a3
    80002354:	f8b402a3          	sb	a1,-123(s0)
    80002358:	46ea7863          	bgeu	s4,a4,800027c8 <__printf+0x650>
    8000235c:	02d7f5bb          	remuw	a1,a5,a3
    80002360:	02059593          	slli	a1,a1,0x20
    80002364:	0205d593          	srli	a1,a1,0x20
    80002368:	00bd85b3          	add	a1,s11,a1
    8000236c:	0005c583          	lbu	a1,0(a1)
    80002370:	02d7d7bb          	divuw	a5,a5,a3
    80002374:	f8b40323          	sb	a1,-122(s0)
    80002378:	3eeaf863          	bgeu	s5,a4,80002768 <__printf+0x5f0>
    8000237c:	02d7f5bb          	remuw	a1,a5,a3
    80002380:	02059593          	slli	a1,a1,0x20
    80002384:	0205d593          	srli	a1,a1,0x20
    80002388:	00bd85b3          	add	a1,s11,a1
    8000238c:	0005c583          	lbu	a1,0(a1)
    80002390:	02d7d7bb          	divuw	a5,a5,a3
    80002394:	f8b403a3          	sb	a1,-121(s0)
    80002398:	42eb7e63          	bgeu	s6,a4,800027d4 <__printf+0x65c>
    8000239c:	02d7f5bb          	remuw	a1,a5,a3
    800023a0:	02059593          	slli	a1,a1,0x20
    800023a4:	0205d593          	srli	a1,a1,0x20
    800023a8:	00bd85b3          	add	a1,s11,a1
    800023ac:	0005c583          	lbu	a1,0(a1)
    800023b0:	02d7d7bb          	divuw	a5,a5,a3
    800023b4:	f8b40423          	sb	a1,-120(s0)
    800023b8:	42ebfc63          	bgeu	s7,a4,800027f0 <__printf+0x678>
    800023bc:	02079793          	slli	a5,a5,0x20
    800023c0:	0207d793          	srli	a5,a5,0x20
    800023c4:	00fd8db3          	add	s11,s11,a5
    800023c8:	000dc703          	lbu	a4,0(s11)
    800023cc:	00a00793          	li	a5,10
    800023d0:	00900c93          	li	s9,9
    800023d4:	f8e404a3          	sb	a4,-119(s0)
    800023d8:	00065c63          	bgez	a2,800023f0 <__printf+0x278>
    800023dc:	f9040713          	addi	a4,s0,-112
    800023e0:	00f70733          	add	a4,a4,a5
    800023e4:	02d00693          	li	a3,45
    800023e8:	fed70823          	sb	a3,-16(a4)
    800023ec:	00078c93          	mv	s9,a5
    800023f0:	f8040793          	addi	a5,s0,-128
    800023f4:	01978cb3          	add	s9,a5,s9
    800023f8:	f7f40d13          	addi	s10,s0,-129
    800023fc:	000cc503          	lbu	a0,0(s9)
    80002400:	fffc8c93          	addi	s9,s9,-1
    80002404:	00000097          	auipc	ra,0x0
    80002408:	b90080e7          	jalr	-1136(ra) # 80001f94 <consputc>
    8000240c:	ffac98e3          	bne	s9,s10,800023fc <__printf+0x284>
    80002410:	00094503          	lbu	a0,0(s2)
    80002414:	e00514e3          	bnez	a0,8000221c <__printf+0xa4>
    80002418:	1a0c1663          	bnez	s8,800025c4 <__printf+0x44c>
    8000241c:	08813083          	ld	ra,136(sp)
    80002420:	08013403          	ld	s0,128(sp)
    80002424:	07813483          	ld	s1,120(sp)
    80002428:	07013903          	ld	s2,112(sp)
    8000242c:	06813983          	ld	s3,104(sp)
    80002430:	06013a03          	ld	s4,96(sp)
    80002434:	05813a83          	ld	s5,88(sp)
    80002438:	05013b03          	ld	s6,80(sp)
    8000243c:	04813b83          	ld	s7,72(sp)
    80002440:	04013c03          	ld	s8,64(sp)
    80002444:	03813c83          	ld	s9,56(sp)
    80002448:	03013d03          	ld	s10,48(sp)
    8000244c:	02813d83          	ld	s11,40(sp)
    80002450:	0d010113          	addi	sp,sp,208
    80002454:	00008067          	ret
    80002458:	07300713          	li	a4,115
    8000245c:	1ce78a63          	beq	a5,a4,80002630 <__printf+0x4b8>
    80002460:	07800713          	li	a4,120
    80002464:	1ee79e63          	bne	a5,a4,80002660 <__printf+0x4e8>
    80002468:	f7843783          	ld	a5,-136(s0)
    8000246c:	0007a703          	lw	a4,0(a5)
    80002470:	00878793          	addi	a5,a5,8
    80002474:	f6f43c23          	sd	a5,-136(s0)
    80002478:	28074263          	bltz	a4,800026fc <__printf+0x584>
    8000247c:	00002d97          	auipc	s11,0x2
    80002480:	d0cd8d93          	addi	s11,s11,-756 # 80004188 <digits>
    80002484:	00f77793          	andi	a5,a4,15
    80002488:	00fd87b3          	add	a5,s11,a5
    8000248c:	0007c683          	lbu	a3,0(a5)
    80002490:	00f00613          	li	a2,15
    80002494:	0007079b          	sext.w	a5,a4
    80002498:	f8d40023          	sb	a3,-128(s0)
    8000249c:	0047559b          	srliw	a1,a4,0x4
    800024a0:	0047569b          	srliw	a3,a4,0x4
    800024a4:	00000c93          	li	s9,0
    800024a8:	0ee65063          	bge	a2,a4,80002588 <__printf+0x410>
    800024ac:	00f6f693          	andi	a3,a3,15
    800024b0:	00dd86b3          	add	a3,s11,a3
    800024b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800024b8:	0087d79b          	srliw	a5,a5,0x8
    800024bc:	00100c93          	li	s9,1
    800024c0:	f8d400a3          	sb	a3,-127(s0)
    800024c4:	0cb67263          	bgeu	a2,a1,80002588 <__printf+0x410>
    800024c8:	00f7f693          	andi	a3,a5,15
    800024cc:	00dd86b3          	add	a3,s11,a3
    800024d0:	0006c583          	lbu	a1,0(a3)
    800024d4:	00f00613          	li	a2,15
    800024d8:	0047d69b          	srliw	a3,a5,0x4
    800024dc:	f8b40123          	sb	a1,-126(s0)
    800024e0:	0047d593          	srli	a1,a5,0x4
    800024e4:	28f67e63          	bgeu	a2,a5,80002780 <__printf+0x608>
    800024e8:	00f6f693          	andi	a3,a3,15
    800024ec:	00dd86b3          	add	a3,s11,a3
    800024f0:	0006c503          	lbu	a0,0(a3)
    800024f4:	0087d813          	srli	a6,a5,0x8
    800024f8:	0087d69b          	srliw	a3,a5,0x8
    800024fc:	f8a401a3          	sb	a0,-125(s0)
    80002500:	28b67663          	bgeu	a2,a1,8000278c <__printf+0x614>
    80002504:	00f6f693          	andi	a3,a3,15
    80002508:	00dd86b3          	add	a3,s11,a3
    8000250c:	0006c583          	lbu	a1,0(a3)
    80002510:	00c7d513          	srli	a0,a5,0xc
    80002514:	00c7d69b          	srliw	a3,a5,0xc
    80002518:	f8b40223          	sb	a1,-124(s0)
    8000251c:	29067a63          	bgeu	a2,a6,800027b0 <__printf+0x638>
    80002520:	00f6f693          	andi	a3,a3,15
    80002524:	00dd86b3          	add	a3,s11,a3
    80002528:	0006c583          	lbu	a1,0(a3)
    8000252c:	0107d813          	srli	a6,a5,0x10
    80002530:	0107d69b          	srliw	a3,a5,0x10
    80002534:	f8b402a3          	sb	a1,-123(s0)
    80002538:	28a67263          	bgeu	a2,a0,800027bc <__printf+0x644>
    8000253c:	00f6f693          	andi	a3,a3,15
    80002540:	00dd86b3          	add	a3,s11,a3
    80002544:	0006c683          	lbu	a3,0(a3)
    80002548:	0147d79b          	srliw	a5,a5,0x14
    8000254c:	f8d40323          	sb	a3,-122(s0)
    80002550:	21067663          	bgeu	a2,a6,8000275c <__printf+0x5e4>
    80002554:	02079793          	slli	a5,a5,0x20
    80002558:	0207d793          	srli	a5,a5,0x20
    8000255c:	00fd8db3          	add	s11,s11,a5
    80002560:	000dc683          	lbu	a3,0(s11)
    80002564:	00800793          	li	a5,8
    80002568:	00700c93          	li	s9,7
    8000256c:	f8d403a3          	sb	a3,-121(s0)
    80002570:	00075c63          	bgez	a4,80002588 <__printf+0x410>
    80002574:	f9040713          	addi	a4,s0,-112
    80002578:	00f70733          	add	a4,a4,a5
    8000257c:	02d00693          	li	a3,45
    80002580:	fed70823          	sb	a3,-16(a4)
    80002584:	00078c93          	mv	s9,a5
    80002588:	f8040793          	addi	a5,s0,-128
    8000258c:	01978cb3          	add	s9,a5,s9
    80002590:	f7f40d13          	addi	s10,s0,-129
    80002594:	000cc503          	lbu	a0,0(s9)
    80002598:	fffc8c93          	addi	s9,s9,-1
    8000259c:	00000097          	auipc	ra,0x0
    800025a0:	9f8080e7          	jalr	-1544(ra) # 80001f94 <consputc>
    800025a4:	ff9d18e3          	bne	s10,s9,80002594 <__printf+0x41c>
    800025a8:	0100006f          	j	800025b8 <__printf+0x440>
    800025ac:	00000097          	auipc	ra,0x0
    800025b0:	9e8080e7          	jalr	-1560(ra) # 80001f94 <consputc>
    800025b4:	000c8493          	mv	s1,s9
    800025b8:	00094503          	lbu	a0,0(s2)
    800025bc:	c60510e3          	bnez	a0,8000221c <__printf+0xa4>
    800025c0:	e40c0ee3          	beqz	s8,8000241c <__printf+0x2a4>
    800025c4:	00003517          	auipc	a0,0x3
    800025c8:	03c50513          	addi	a0,a0,60 # 80005600 <pr>
    800025cc:	00001097          	auipc	ra,0x1
    800025d0:	94c080e7          	jalr	-1716(ra) # 80002f18 <release>
    800025d4:	e49ff06f          	j	8000241c <__printf+0x2a4>
    800025d8:	f7843783          	ld	a5,-136(s0)
    800025dc:	03000513          	li	a0,48
    800025e0:	01000d13          	li	s10,16
    800025e4:	00878713          	addi	a4,a5,8
    800025e8:	0007bc83          	ld	s9,0(a5)
    800025ec:	f6e43c23          	sd	a4,-136(s0)
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	9a4080e7          	jalr	-1628(ra) # 80001f94 <consputc>
    800025f8:	07800513          	li	a0,120
    800025fc:	00000097          	auipc	ra,0x0
    80002600:	998080e7          	jalr	-1640(ra) # 80001f94 <consputc>
    80002604:	00002d97          	auipc	s11,0x2
    80002608:	b84d8d93          	addi	s11,s11,-1148 # 80004188 <digits>
    8000260c:	03ccd793          	srli	a5,s9,0x3c
    80002610:	00fd87b3          	add	a5,s11,a5
    80002614:	0007c503          	lbu	a0,0(a5)
    80002618:	fffd0d1b          	addiw	s10,s10,-1
    8000261c:	004c9c93          	slli	s9,s9,0x4
    80002620:	00000097          	auipc	ra,0x0
    80002624:	974080e7          	jalr	-1676(ra) # 80001f94 <consputc>
    80002628:	fe0d12e3          	bnez	s10,8000260c <__printf+0x494>
    8000262c:	f8dff06f          	j	800025b8 <__printf+0x440>
    80002630:	f7843783          	ld	a5,-136(s0)
    80002634:	0007bc83          	ld	s9,0(a5)
    80002638:	00878793          	addi	a5,a5,8
    8000263c:	f6f43c23          	sd	a5,-136(s0)
    80002640:	000c9a63          	bnez	s9,80002654 <__printf+0x4dc>
    80002644:	1080006f          	j	8000274c <__printf+0x5d4>
    80002648:	001c8c93          	addi	s9,s9,1
    8000264c:	00000097          	auipc	ra,0x0
    80002650:	948080e7          	jalr	-1720(ra) # 80001f94 <consputc>
    80002654:	000cc503          	lbu	a0,0(s9)
    80002658:	fe0518e3          	bnez	a0,80002648 <__printf+0x4d0>
    8000265c:	f5dff06f          	j	800025b8 <__printf+0x440>
    80002660:	02500513          	li	a0,37
    80002664:	00000097          	auipc	ra,0x0
    80002668:	930080e7          	jalr	-1744(ra) # 80001f94 <consputc>
    8000266c:	000c8513          	mv	a0,s9
    80002670:	00000097          	auipc	ra,0x0
    80002674:	924080e7          	jalr	-1756(ra) # 80001f94 <consputc>
    80002678:	f41ff06f          	j	800025b8 <__printf+0x440>
    8000267c:	02500513          	li	a0,37
    80002680:	00000097          	auipc	ra,0x0
    80002684:	914080e7          	jalr	-1772(ra) # 80001f94 <consputc>
    80002688:	f31ff06f          	j	800025b8 <__printf+0x440>
    8000268c:	00030513          	mv	a0,t1
    80002690:	00000097          	auipc	ra,0x0
    80002694:	7bc080e7          	jalr	1980(ra) # 80002e4c <acquire>
    80002698:	b4dff06f          	j	800021e4 <__printf+0x6c>
    8000269c:	40c0053b          	negw	a0,a2
    800026a0:	00a00713          	li	a4,10
    800026a4:	02e576bb          	remuw	a3,a0,a4
    800026a8:	00002d97          	auipc	s11,0x2
    800026ac:	ae0d8d93          	addi	s11,s11,-1312 # 80004188 <digits>
    800026b0:	ff700593          	li	a1,-9
    800026b4:	02069693          	slli	a3,a3,0x20
    800026b8:	0206d693          	srli	a3,a3,0x20
    800026bc:	00dd86b3          	add	a3,s11,a3
    800026c0:	0006c683          	lbu	a3,0(a3)
    800026c4:	02e557bb          	divuw	a5,a0,a4
    800026c8:	f8d40023          	sb	a3,-128(s0)
    800026cc:	10b65e63          	bge	a2,a1,800027e8 <__printf+0x670>
    800026d0:	06300593          	li	a1,99
    800026d4:	02e7f6bb          	remuw	a3,a5,a4
    800026d8:	02069693          	slli	a3,a3,0x20
    800026dc:	0206d693          	srli	a3,a3,0x20
    800026e0:	00dd86b3          	add	a3,s11,a3
    800026e4:	0006c683          	lbu	a3,0(a3)
    800026e8:	02e7d73b          	divuw	a4,a5,a4
    800026ec:	00200793          	li	a5,2
    800026f0:	f8d400a3          	sb	a3,-127(s0)
    800026f4:	bca5ece3          	bltu	a1,a0,800022cc <__printf+0x154>
    800026f8:	ce5ff06f          	j	800023dc <__printf+0x264>
    800026fc:	40e007bb          	negw	a5,a4
    80002700:	00002d97          	auipc	s11,0x2
    80002704:	a88d8d93          	addi	s11,s11,-1400 # 80004188 <digits>
    80002708:	00f7f693          	andi	a3,a5,15
    8000270c:	00dd86b3          	add	a3,s11,a3
    80002710:	0006c583          	lbu	a1,0(a3)
    80002714:	ff100613          	li	a2,-15
    80002718:	0047d69b          	srliw	a3,a5,0x4
    8000271c:	f8b40023          	sb	a1,-128(s0)
    80002720:	0047d59b          	srliw	a1,a5,0x4
    80002724:	0ac75e63          	bge	a4,a2,800027e0 <__printf+0x668>
    80002728:	00f6f693          	andi	a3,a3,15
    8000272c:	00dd86b3          	add	a3,s11,a3
    80002730:	0006c603          	lbu	a2,0(a3)
    80002734:	00f00693          	li	a3,15
    80002738:	0087d79b          	srliw	a5,a5,0x8
    8000273c:	f8c400a3          	sb	a2,-127(s0)
    80002740:	d8b6e4e3          	bltu	a3,a1,800024c8 <__printf+0x350>
    80002744:	00200793          	li	a5,2
    80002748:	e2dff06f          	j	80002574 <__printf+0x3fc>
    8000274c:	00002c97          	auipc	s9,0x2
    80002750:	a1cc8c93          	addi	s9,s9,-1508 # 80004168 <_ZZ12printIntegermE6digits+0x148>
    80002754:	02800513          	li	a0,40
    80002758:	ef1ff06f          	j	80002648 <__printf+0x4d0>
    8000275c:	00700793          	li	a5,7
    80002760:	00600c93          	li	s9,6
    80002764:	e0dff06f          	j	80002570 <__printf+0x3f8>
    80002768:	00700793          	li	a5,7
    8000276c:	00600c93          	li	s9,6
    80002770:	c69ff06f          	j	800023d8 <__printf+0x260>
    80002774:	00300793          	li	a5,3
    80002778:	00200c93          	li	s9,2
    8000277c:	c5dff06f          	j	800023d8 <__printf+0x260>
    80002780:	00300793          	li	a5,3
    80002784:	00200c93          	li	s9,2
    80002788:	de9ff06f          	j	80002570 <__printf+0x3f8>
    8000278c:	00400793          	li	a5,4
    80002790:	00300c93          	li	s9,3
    80002794:	dddff06f          	j	80002570 <__printf+0x3f8>
    80002798:	00400793          	li	a5,4
    8000279c:	00300c93          	li	s9,3
    800027a0:	c39ff06f          	j	800023d8 <__printf+0x260>
    800027a4:	00500793          	li	a5,5
    800027a8:	00400c93          	li	s9,4
    800027ac:	c2dff06f          	j	800023d8 <__printf+0x260>
    800027b0:	00500793          	li	a5,5
    800027b4:	00400c93          	li	s9,4
    800027b8:	db9ff06f          	j	80002570 <__printf+0x3f8>
    800027bc:	00600793          	li	a5,6
    800027c0:	00500c93          	li	s9,5
    800027c4:	dadff06f          	j	80002570 <__printf+0x3f8>
    800027c8:	00600793          	li	a5,6
    800027cc:	00500c93          	li	s9,5
    800027d0:	c09ff06f          	j	800023d8 <__printf+0x260>
    800027d4:	00800793          	li	a5,8
    800027d8:	00700c93          	li	s9,7
    800027dc:	bfdff06f          	j	800023d8 <__printf+0x260>
    800027e0:	00100793          	li	a5,1
    800027e4:	d91ff06f          	j	80002574 <__printf+0x3fc>
    800027e8:	00100793          	li	a5,1
    800027ec:	bf1ff06f          	j	800023dc <__printf+0x264>
    800027f0:	00900793          	li	a5,9
    800027f4:	00800c93          	li	s9,8
    800027f8:	be1ff06f          	j	800023d8 <__printf+0x260>
    800027fc:	00002517          	auipc	a0,0x2
    80002800:	97450513          	addi	a0,a0,-1676 # 80004170 <_ZZ12printIntegermE6digits+0x150>
    80002804:	00000097          	auipc	ra,0x0
    80002808:	918080e7          	jalr	-1768(ra) # 8000211c <panic>

000000008000280c <printfinit>:
    8000280c:	fe010113          	addi	sp,sp,-32
    80002810:	00813823          	sd	s0,16(sp)
    80002814:	00913423          	sd	s1,8(sp)
    80002818:	00113c23          	sd	ra,24(sp)
    8000281c:	02010413          	addi	s0,sp,32
    80002820:	00003497          	auipc	s1,0x3
    80002824:	de048493          	addi	s1,s1,-544 # 80005600 <pr>
    80002828:	00048513          	mv	a0,s1
    8000282c:	00002597          	auipc	a1,0x2
    80002830:	95458593          	addi	a1,a1,-1708 # 80004180 <_ZZ12printIntegermE6digits+0x160>
    80002834:	00000097          	auipc	ra,0x0
    80002838:	5f4080e7          	jalr	1524(ra) # 80002e28 <initlock>
    8000283c:	01813083          	ld	ra,24(sp)
    80002840:	01013403          	ld	s0,16(sp)
    80002844:	0004ac23          	sw	zero,24(s1)
    80002848:	00813483          	ld	s1,8(sp)
    8000284c:	02010113          	addi	sp,sp,32
    80002850:	00008067          	ret

0000000080002854 <uartinit>:
    80002854:	ff010113          	addi	sp,sp,-16
    80002858:	00813423          	sd	s0,8(sp)
    8000285c:	01010413          	addi	s0,sp,16
    80002860:	100007b7          	lui	a5,0x10000
    80002864:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002868:	f8000713          	li	a4,-128
    8000286c:	00e781a3          	sb	a4,3(a5)
    80002870:	00300713          	li	a4,3
    80002874:	00e78023          	sb	a4,0(a5)
    80002878:	000780a3          	sb	zero,1(a5)
    8000287c:	00e781a3          	sb	a4,3(a5)
    80002880:	00700693          	li	a3,7
    80002884:	00d78123          	sb	a3,2(a5)
    80002888:	00e780a3          	sb	a4,1(a5)
    8000288c:	00813403          	ld	s0,8(sp)
    80002890:	01010113          	addi	sp,sp,16
    80002894:	00008067          	ret

0000000080002898 <uartputc>:
    80002898:	00002797          	auipc	a5,0x2
    8000289c:	b107a783          	lw	a5,-1264(a5) # 800043a8 <panicked>
    800028a0:	00078463          	beqz	a5,800028a8 <uartputc+0x10>
    800028a4:	0000006f          	j	800028a4 <uartputc+0xc>
    800028a8:	fd010113          	addi	sp,sp,-48
    800028ac:	02813023          	sd	s0,32(sp)
    800028b0:	00913c23          	sd	s1,24(sp)
    800028b4:	01213823          	sd	s2,16(sp)
    800028b8:	01313423          	sd	s3,8(sp)
    800028bc:	02113423          	sd	ra,40(sp)
    800028c0:	03010413          	addi	s0,sp,48
    800028c4:	00002917          	auipc	s2,0x2
    800028c8:	aec90913          	addi	s2,s2,-1300 # 800043b0 <uart_tx_r>
    800028cc:	00093783          	ld	a5,0(s2)
    800028d0:	00002497          	auipc	s1,0x2
    800028d4:	ae848493          	addi	s1,s1,-1304 # 800043b8 <uart_tx_w>
    800028d8:	0004b703          	ld	a4,0(s1)
    800028dc:	02078693          	addi	a3,a5,32
    800028e0:	00050993          	mv	s3,a0
    800028e4:	02e69c63          	bne	a3,a4,8000291c <uartputc+0x84>
    800028e8:	00001097          	auipc	ra,0x1
    800028ec:	834080e7          	jalr	-1996(ra) # 8000311c <push_on>
    800028f0:	00093783          	ld	a5,0(s2)
    800028f4:	0004b703          	ld	a4,0(s1)
    800028f8:	02078793          	addi	a5,a5,32
    800028fc:	00e79463          	bne	a5,a4,80002904 <uartputc+0x6c>
    80002900:	0000006f          	j	80002900 <uartputc+0x68>
    80002904:	00001097          	auipc	ra,0x1
    80002908:	88c080e7          	jalr	-1908(ra) # 80003190 <pop_on>
    8000290c:	00093783          	ld	a5,0(s2)
    80002910:	0004b703          	ld	a4,0(s1)
    80002914:	02078693          	addi	a3,a5,32
    80002918:	fce688e3          	beq	a3,a4,800028e8 <uartputc+0x50>
    8000291c:	01f77693          	andi	a3,a4,31
    80002920:	00003597          	auipc	a1,0x3
    80002924:	d0058593          	addi	a1,a1,-768 # 80005620 <uart_tx_buf>
    80002928:	00d586b3          	add	a3,a1,a3
    8000292c:	00170713          	addi	a4,a4,1
    80002930:	01368023          	sb	s3,0(a3)
    80002934:	00e4b023          	sd	a4,0(s1)
    80002938:	10000637          	lui	a2,0x10000
    8000293c:	02f71063          	bne	a4,a5,8000295c <uartputc+0xc4>
    80002940:	0340006f          	j	80002974 <uartputc+0xdc>
    80002944:	00074703          	lbu	a4,0(a4)
    80002948:	00f93023          	sd	a5,0(s2)
    8000294c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002950:	00093783          	ld	a5,0(s2)
    80002954:	0004b703          	ld	a4,0(s1)
    80002958:	00f70e63          	beq	a4,a5,80002974 <uartputc+0xdc>
    8000295c:	00564683          	lbu	a3,5(a2)
    80002960:	01f7f713          	andi	a4,a5,31
    80002964:	00e58733          	add	a4,a1,a4
    80002968:	0206f693          	andi	a3,a3,32
    8000296c:	00178793          	addi	a5,a5,1
    80002970:	fc069ae3          	bnez	a3,80002944 <uartputc+0xac>
    80002974:	02813083          	ld	ra,40(sp)
    80002978:	02013403          	ld	s0,32(sp)
    8000297c:	01813483          	ld	s1,24(sp)
    80002980:	01013903          	ld	s2,16(sp)
    80002984:	00813983          	ld	s3,8(sp)
    80002988:	03010113          	addi	sp,sp,48
    8000298c:	00008067          	ret

0000000080002990 <uartputc_sync>:
    80002990:	ff010113          	addi	sp,sp,-16
    80002994:	00813423          	sd	s0,8(sp)
    80002998:	01010413          	addi	s0,sp,16
    8000299c:	00002717          	auipc	a4,0x2
    800029a0:	a0c72703          	lw	a4,-1524(a4) # 800043a8 <panicked>
    800029a4:	02071663          	bnez	a4,800029d0 <uartputc_sync+0x40>
    800029a8:	00050793          	mv	a5,a0
    800029ac:	100006b7          	lui	a3,0x10000
    800029b0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800029b4:	02077713          	andi	a4,a4,32
    800029b8:	fe070ce3          	beqz	a4,800029b0 <uartputc_sync+0x20>
    800029bc:	0ff7f793          	andi	a5,a5,255
    800029c0:	00f68023          	sb	a5,0(a3)
    800029c4:	00813403          	ld	s0,8(sp)
    800029c8:	01010113          	addi	sp,sp,16
    800029cc:	00008067          	ret
    800029d0:	0000006f          	j	800029d0 <uartputc_sync+0x40>

00000000800029d4 <uartstart>:
    800029d4:	ff010113          	addi	sp,sp,-16
    800029d8:	00813423          	sd	s0,8(sp)
    800029dc:	01010413          	addi	s0,sp,16
    800029e0:	00002617          	auipc	a2,0x2
    800029e4:	9d060613          	addi	a2,a2,-1584 # 800043b0 <uart_tx_r>
    800029e8:	00002517          	auipc	a0,0x2
    800029ec:	9d050513          	addi	a0,a0,-1584 # 800043b8 <uart_tx_w>
    800029f0:	00063783          	ld	a5,0(a2)
    800029f4:	00053703          	ld	a4,0(a0)
    800029f8:	04f70263          	beq	a4,a5,80002a3c <uartstart+0x68>
    800029fc:	100005b7          	lui	a1,0x10000
    80002a00:	00003817          	auipc	a6,0x3
    80002a04:	c2080813          	addi	a6,a6,-992 # 80005620 <uart_tx_buf>
    80002a08:	01c0006f          	j	80002a24 <uartstart+0x50>
    80002a0c:	0006c703          	lbu	a4,0(a3)
    80002a10:	00f63023          	sd	a5,0(a2)
    80002a14:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002a18:	00063783          	ld	a5,0(a2)
    80002a1c:	00053703          	ld	a4,0(a0)
    80002a20:	00f70e63          	beq	a4,a5,80002a3c <uartstart+0x68>
    80002a24:	01f7f713          	andi	a4,a5,31
    80002a28:	00e806b3          	add	a3,a6,a4
    80002a2c:	0055c703          	lbu	a4,5(a1)
    80002a30:	00178793          	addi	a5,a5,1
    80002a34:	02077713          	andi	a4,a4,32
    80002a38:	fc071ae3          	bnez	a4,80002a0c <uartstart+0x38>
    80002a3c:	00813403          	ld	s0,8(sp)
    80002a40:	01010113          	addi	sp,sp,16
    80002a44:	00008067          	ret

0000000080002a48 <uartgetc>:
    80002a48:	ff010113          	addi	sp,sp,-16
    80002a4c:	00813423          	sd	s0,8(sp)
    80002a50:	01010413          	addi	s0,sp,16
    80002a54:	10000737          	lui	a4,0x10000
    80002a58:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002a5c:	0017f793          	andi	a5,a5,1
    80002a60:	00078c63          	beqz	a5,80002a78 <uartgetc+0x30>
    80002a64:	00074503          	lbu	a0,0(a4)
    80002a68:	0ff57513          	andi	a0,a0,255
    80002a6c:	00813403          	ld	s0,8(sp)
    80002a70:	01010113          	addi	sp,sp,16
    80002a74:	00008067          	ret
    80002a78:	fff00513          	li	a0,-1
    80002a7c:	ff1ff06f          	j	80002a6c <uartgetc+0x24>

0000000080002a80 <uartintr>:
    80002a80:	100007b7          	lui	a5,0x10000
    80002a84:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002a88:	0017f793          	andi	a5,a5,1
    80002a8c:	0a078463          	beqz	a5,80002b34 <uartintr+0xb4>
    80002a90:	fe010113          	addi	sp,sp,-32
    80002a94:	00813823          	sd	s0,16(sp)
    80002a98:	00913423          	sd	s1,8(sp)
    80002a9c:	00113c23          	sd	ra,24(sp)
    80002aa0:	02010413          	addi	s0,sp,32
    80002aa4:	100004b7          	lui	s1,0x10000
    80002aa8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002aac:	0ff57513          	andi	a0,a0,255
    80002ab0:	fffff097          	auipc	ra,0xfffff
    80002ab4:	534080e7          	jalr	1332(ra) # 80001fe4 <consoleintr>
    80002ab8:	0054c783          	lbu	a5,5(s1)
    80002abc:	0017f793          	andi	a5,a5,1
    80002ac0:	fe0794e3          	bnez	a5,80002aa8 <uartintr+0x28>
    80002ac4:	00002617          	auipc	a2,0x2
    80002ac8:	8ec60613          	addi	a2,a2,-1812 # 800043b0 <uart_tx_r>
    80002acc:	00002517          	auipc	a0,0x2
    80002ad0:	8ec50513          	addi	a0,a0,-1812 # 800043b8 <uart_tx_w>
    80002ad4:	00063783          	ld	a5,0(a2)
    80002ad8:	00053703          	ld	a4,0(a0)
    80002adc:	04f70263          	beq	a4,a5,80002b20 <uartintr+0xa0>
    80002ae0:	100005b7          	lui	a1,0x10000
    80002ae4:	00003817          	auipc	a6,0x3
    80002ae8:	b3c80813          	addi	a6,a6,-1220 # 80005620 <uart_tx_buf>
    80002aec:	01c0006f          	j	80002b08 <uartintr+0x88>
    80002af0:	0006c703          	lbu	a4,0(a3)
    80002af4:	00f63023          	sd	a5,0(a2)
    80002af8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002afc:	00063783          	ld	a5,0(a2)
    80002b00:	00053703          	ld	a4,0(a0)
    80002b04:	00f70e63          	beq	a4,a5,80002b20 <uartintr+0xa0>
    80002b08:	01f7f713          	andi	a4,a5,31
    80002b0c:	00e806b3          	add	a3,a6,a4
    80002b10:	0055c703          	lbu	a4,5(a1)
    80002b14:	00178793          	addi	a5,a5,1
    80002b18:	02077713          	andi	a4,a4,32
    80002b1c:	fc071ae3          	bnez	a4,80002af0 <uartintr+0x70>
    80002b20:	01813083          	ld	ra,24(sp)
    80002b24:	01013403          	ld	s0,16(sp)
    80002b28:	00813483          	ld	s1,8(sp)
    80002b2c:	02010113          	addi	sp,sp,32
    80002b30:	00008067          	ret
    80002b34:	00002617          	auipc	a2,0x2
    80002b38:	87c60613          	addi	a2,a2,-1924 # 800043b0 <uart_tx_r>
    80002b3c:	00002517          	auipc	a0,0x2
    80002b40:	87c50513          	addi	a0,a0,-1924 # 800043b8 <uart_tx_w>
    80002b44:	00063783          	ld	a5,0(a2)
    80002b48:	00053703          	ld	a4,0(a0)
    80002b4c:	04f70263          	beq	a4,a5,80002b90 <uartintr+0x110>
    80002b50:	100005b7          	lui	a1,0x10000
    80002b54:	00003817          	auipc	a6,0x3
    80002b58:	acc80813          	addi	a6,a6,-1332 # 80005620 <uart_tx_buf>
    80002b5c:	01c0006f          	j	80002b78 <uartintr+0xf8>
    80002b60:	0006c703          	lbu	a4,0(a3)
    80002b64:	00f63023          	sd	a5,0(a2)
    80002b68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002b6c:	00063783          	ld	a5,0(a2)
    80002b70:	00053703          	ld	a4,0(a0)
    80002b74:	02f70063          	beq	a4,a5,80002b94 <uartintr+0x114>
    80002b78:	01f7f713          	andi	a4,a5,31
    80002b7c:	00e806b3          	add	a3,a6,a4
    80002b80:	0055c703          	lbu	a4,5(a1)
    80002b84:	00178793          	addi	a5,a5,1
    80002b88:	02077713          	andi	a4,a4,32
    80002b8c:	fc071ae3          	bnez	a4,80002b60 <uartintr+0xe0>
    80002b90:	00008067          	ret
    80002b94:	00008067          	ret

0000000080002b98 <kinit>:
    80002b98:	fc010113          	addi	sp,sp,-64
    80002b9c:	02913423          	sd	s1,40(sp)
    80002ba0:	fffff7b7          	lui	a5,0xfffff
    80002ba4:	00004497          	auipc	s1,0x4
    80002ba8:	a9b48493          	addi	s1,s1,-1381 # 8000663f <end+0xfff>
    80002bac:	02813823          	sd	s0,48(sp)
    80002bb0:	01313c23          	sd	s3,24(sp)
    80002bb4:	00f4f4b3          	and	s1,s1,a5
    80002bb8:	02113c23          	sd	ra,56(sp)
    80002bbc:	03213023          	sd	s2,32(sp)
    80002bc0:	01413823          	sd	s4,16(sp)
    80002bc4:	01513423          	sd	s5,8(sp)
    80002bc8:	04010413          	addi	s0,sp,64
    80002bcc:	000017b7          	lui	a5,0x1
    80002bd0:	01100993          	li	s3,17
    80002bd4:	00f487b3          	add	a5,s1,a5
    80002bd8:	01b99993          	slli	s3,s3,0x1b
    80002bdc:	06f9e063          	bltu	s3,a5,80002c3c <kinit+0xa4>
    80002be0:	00003a97          	auipc	s5,0x3
    80002be4:	a60a8a93          	addi	s5,s5,-1440 # 80005640 <end>
    80002be8:	0754ec63          	bltu	s1,s5,80002c60 <kinit+0xc8>
    80002bec:	0734fa63          	bgeu	s1,s3,80002c60 <kinit+0xc8>
    80002bf0:	00088a37          	lui	s4,0x88
    80002bf4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002bf8:	00001917          	auipc	s2,0x1
    80002bfc:	7c890913          	addi	s2,s2,1992 # 800043c0 <kmem>
    80002c00:	00ca1a13          	slli	s4,s4,0xc
    80002c04:	0140006f          	j	80002c18 <kinit+0x80>
    80002c08:	000017b7          	lui	a5,0x1
    80002c0c:	00f484b3          	add	s1,s1,a5
    80002c10:	0554e863          	bltu	s1,s5,80002c60 <kinit+0xc8>
    80002c14:	0534f663          	bgeu	s1,s3,80002c60 <kinit+0xc8>
    80002c18:	00001637          	lui	a2,0x1
    80002c1c:	00100593          	li	a1,1
    80002c20:	00048513          	mv	a0,s1
    80002c24:	00000097          	auipc	ra,0x0
    80002c28:	5e4080e7          	jalr	1508(ra) # 80003208 <__memset>
    80002c2c:	00093783          	ld	a5,0(s2)
    80002c30:	00f4b023          	sd	a5,0(s1)
    80002c34:	00993023          	sd	s1,0(s2)
    80002c38:	fd4498e3          	bne	s1,s4,80002c08 <kinit+0x70>
    80002c3c:	03813083          	ld	ra,56(sp)
    80002c40:	03013403          	ld	s0,48(sp)
    80002c44:	02813483          	ld	s1,40(sp)
    80002c48:	02013903          	ld	s2,32(sp)
    80002c4c:	01813983          	ld	s3,24(sp)
    80002c50:	01013a03          	ld	s4,16(sp)
    80002c54:	00813a83          	ld	s5,8(sp)
    80002c58:	04010113          	addi	sp,sp,64
    80002c5c:	00008067          	ret
    80002c60:	00001517          	auipc	a0,0x1
    80002c64:	54050513          	addi	a0,a0,1344 # 800041a0 <digits+0x18>
    80002c68:	fffff097          	auipc	ra,0xfffff
    80002c6c:	4b4080e7          	jalr	1204(ra) # 8000211c <panic>

0000000080002c70 <freerange>:
    80002c70:	fc010113          	addi	sp,sp,-64
    80002c74:	000017b7          	lui	a5,0x1
    80002c78:	02913423          	sd	s1,40(sp)
    80002c7c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002c80:	009504b3          	add	s1,a0,s1
    80002c84:	fffff537          	lui	a0,0xfffff
    80002c88:	02813823          	sd	s0,48(sp)
    80002c8c:	02113c23          	sd	ra,56(sp)
    80002c90:	03213023          	sd	s2,32(sp)
    80002c94:	01313c23          	sd	s3,24(sp)
    80002c98:	01413823          	sd	s4,16(sp)
    80002c9c:	01513423          	sd	s5,8(sp)
    80002ca0:	01613023          	sd	s6,0(sp)
    80002ca4:	04010413          	addi	s0,sp,64
    80002ca8:	00a4f4b3          	and	s1,s1,a0
    80002cac:	00f487b3          	add	a5,s1,a5
    80002cb0:	06f5e463          	bltu	a1,a5,80002d18 <freerange+0xa8>
    80002cb4:	00003a97          	auipc	s5,0x3
    80002cb8:	98ca8a93          	addi	s5,s5,-1652 # 80005640 <end>
    80002cbc:	0954e263          	bltu	s1,s5,80002d40 <freerange+0xd0>
    80002cc0:	01100993          	li	s3,17
    80002cc4:	01b99993          	slli	s3,s3,0x1b
    80002cc8:	0734fc63          	bgeu	s1,s3,80002d40 <freerange+0xd0>
    80002ccc:	00058a13          	mv	s4,a1
    80002cd0:	00001917          	auipc	s2,0x1
    80002cd4:	6f090913          	addi	s2,s2,1776 # 800043c0 <kmem>
    80002cd8:	00002b37          	lui	s6,0x2
    80002cdc:	0140006f          	j	80002cf0 <freerange+0x80>
    80002ce0:	000017b7          	lui	a5,0x1
    80002ce4:	00f484b3          	add	s1,s1,a5
    80002ce8:	0554ec63          	bltu	s1,s5,80002d40 <freerange+0xd0>
    80002cec:	0534fa63          	bgeu	s1,s3,80002d40 <freerange+0xd0>
    80002cf0:	00001637          	lui	a2,0x1
    80002cf4:	00100593          	li	a1,1
    80002cf8:	00048513          	mv	a0,s1
    80002cfc:	00000097          	auipc	ra,0x0
    80002d00:	50c080e7          	jalr	1292(ra) # 80003208 <__memset>
    80002d04:	00093703          	ld	a4,0(s2)
    80002d08:	016487b3          	add	a5,s1,s6
    80002d0c:	00e4b023          	sd	a4,0(s1)
    80002d10:	00993023          	sd	s1,0(s2)
    80002d14:	fcfa76e3          	bgeu	s4,a5,80002ce0 <freerange+0x70>
    80002d18:	03813083          	ld	ra,56(sp)
    80002d1c:	03013403          	ld	s0,48(sp)
    80002d20:	02813483          	ld	s1,40(sp)
    80002d24:	02013903          	ld	s2,32(sp)
    80002d28:	01813983          	ld	s3,24(sp)
    80002d2c:	01013a03          	ld	s4,16(sp)
    80002d30:	00813a83          	ld	s5,8(sp)
    80002d34:	00013b03          	ld	s6,0(sp)
    80002d38:	04010113          	addi	sp,sp,64
    80002d3c:	00008067          	ret
    80002d40:	00001517          	auipc	a0,0x1
    80002d44:	46050513          	addi	a0,a0,1120 # 800041a0 <digits+0x18>
    80002d48:	fffff097          	auipc	ra,0xfffff
    80002d4c:	3d4080e7          	jalr	980(ra) # 8000211c <panic>

0000000080002d50 <kfree>:
    80002d50:	fe010113          	addi	sp,sp,-32
    80002d54:	00813823          	sd	s0,16(sp)
    80002d58:	00113c23          	sd	ra,24(sp)
    80002d5c:	00913423          	sd	s1,8(sp)
    80002d60:	02010413          	addi	s0,sp,32
    80002d64:	03451793          	slli	a5,a0,0x34
    80002d68:	04079c63          	bnez	a5,80002dc0 <kfree+0x70>
    80002d6c:	00003797          	auipc	a5,0x3
    80002d70:	8d478793          	addi	a5,a5,-1836 # 80005640 <end>
    80002d74:	00050493          	mv	s1,a0
    80002d78:	04f56463          	bltu	a0,a5,80002dc0 <kfree+0x70>
    80002d7c:	01100793          	li	a5,17
    80002d80:	01b79793          	slli	a5,a5,0x1b
    80002d84:	02f57e63          	bgeu	a0,a5,80002dc0 <kfree+0x70>
    80002d88:	00001637          	lui	a2,0x1
    80002d8c:	00100593          	li	a1,1
    80002d90:	00000097          	auipc	ra,0x0
    80002d94:	478080e7          	jalr	1144(ra) # 80003208 <__memset>
    80002d98:	00001797          	auipc	a5,0x1
    80002d9c:	62878793          	addi	a5,a5,1576 # 800043c0 <kmem>
    80002da0:	0007b703          	ld	a4,0(a5)
    80002da4:	01813083          	ld	ra,24(sp)
    80002da8:	01013403          	ld	s0,16(sp)
    80002dac:	00e4b023          	sd	a4,0(s1)
    80002db0:	0097b023          	sd	s1,0(a5)
    80002db4:	00813483          	ld	s1,8(sp)
    80002db8:	02010113          	addi	sp,sp,32
    80002dbc:	00008067          	ret
    80002dc0:	00001517          	auipc	a0,0x1
    80002dc4:	3e050513          	addi	a0,a0,992 # 800041a0 <digits+0x18>
    80002dc8:	fffff097          	auipc	ra,0xfffff
    80002dcc:	354080e7          	jalr	852(ra) # 8000211c <panic>

0000000080002dd0 <kalloc>:
    80002dd0:	fe010113          	addi	sp,sp,-32
    80002dd4:	00813823          	sd	s0,16(sp)
    80002dd8:	00913423          	sd	s1,8(sp)
    80002ddc:	00113c23          	sd	ra,24(sp)
    80002de0:	02010413          	addi	s0,sp,32
    80002de4:	00001797          	auipc	a5,0x1
    80002de8:	5dc78793          	addi	a5,a5,1500 # 800043c0 <kmem>
    80002dec:	0007b483          	ld	s1,0(a5)
    80002df0:	02048063          	beqz	s1,80002e10 <kalloc+0x40>
    80002df4:	0004b703          	ld	a4,0(s1)
    80002df8:	00001637          	lui	a2,0x1
    80002dfc:	00500593          	li	a1,5
    80002e00:	00048513          	mv	a0,s1
    80002e04:	00e7b023          	sd	a4,0(a5)
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	400080e7          	jalr	1024(ra) # 80003208 <__memset>
    80002e10:	01813083          	ld	ra,24(sp)
    80002e14:	01013403          	ld	s0,16(sp)
    80002e18:	00048513          	mv	a0,s1
    80002e1c:	00813483          	ld	s1,8(sp)
    80002e20:	02010113          	addi	sp,sp,32
    80002e24:	00008067          	ret

0000000080002e28 <initlock>:
    80002e28:	ff010113          	addi	sp,sp,-16
    80002e2c:	00813423          	sd	s0,8(sp)
    80002e30:	01010413          	addi	s0,sp,16
    80002e34:	00813403          	ld	s0,8(sp)
    80002e38:	00b53423          	sd	a1,8(a0)
    80002e3c:	00052023          	sw	zero,0(a0)
    80002e40:	00053823          	sd	zero,16(a0)
    80002e44:	01010113          	addi	sp,sp,16
    80002e48:	00008067          	ret

0000000080002e4c <acquire>:
    80002e4c:	fe010113          	addi	sp,sp,-32
    80002e50:	00813823          	sd	s0,16(sp)
    80002e54:	00913423          	sd	s1,8(sp)
    80002e58:	00113c23          	sd	ra,24(sp)
    80002e5c:	01213023          	sd	s2,0(sp)
    80002e60:	02010413          	addi	s0,sp,32
    80002e64:	00050493          	mv	s1,a0
    80002e68:	10002973          	csrr	s2,sstatus
    80002e6c:	100027f3          	csrr	a5,sstatus
    80002e70:	ffd7f793          	andi	a5,a5,-3
    80002e74:	10079073          	csrw	sstatus,a5
    80002e78:	fffff097          	auipc	ra,0xfffff
    80002e7c:	8e4080e7          	jalr	-1820(ra) # 8000175c <mycpu>
    80002e80:	07852783          	lw	a5,120(a0)
    80002e84:	06078e63          	beqz	a5,80002f00 <acquire+0xb4>
    80002e88:	fffff097          	auipc	ra,0xfffff
    80002e8c:	8d4080e7          	jalr	-1836(ra) # 8000175c <mycpu>
    80002e90:	07852783          	lw	a5,120(a0)
    80002e94:	0004a703          	lw	a4,0(s1)
    80002e98:	0017879b          	addiw	a5,a5,1
    80002e9c:	06f52c23          	sw	a5,120(a0)
    80002ea0:	04071063          	bnez	a4,80002ee0 <acquire+0x94>
    80002ea4:	00100713          	li	a4,1
    80002ea8:	00070793          	mv	a5,a4
    80002eac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002eb0:	0007879b          	sext.w	a5,a5
    80002eb4:	fe079ae3          	bnez	a5,80002ea8 <acquire+0x5c>
    80002eb8:	0ff0000f          	fence
    80002ebc:	fffff097          	auipc	ra,0xfffff
    80002ec0:	8a0080e7          	jalr	-1888(ra) # 8000175c <mycpu>
    80002ec4:	01813083          	ld	ra,24(sp)
    80002ec8:	01013403          	ld	s0,16(sp)
    80002ecc:	00a4b823          	sd	a0,16(s1)
    80002ed0:	00013903          	ld	s2,0(sp)
    80002ed4:	00813483          	ld	s1,8(sp)
    80002ed8:	02010113          	addi	sp,sp,32
    80002edc:	00008067          	ret
    80002ee0:	0104b903          	ld	s2,16(s1)
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	878080e7          	jalr	-1928(ra) # 8000175c <mycpu>
    80002eec:	faa91ce3          	bne	s2,a0,80002ea4 <acquire+0x58>
    80002ef0:	00001517          	auipc	a0,0x1
    80002ef4:	2b850513          	addi	a0,a0,696 # 800041a8 <digits+0x20>
    80002ef8:	fffff097          	auipc	ra,0xfffff
    80002efc:	224080e7          	jalr	548(ra) # 8000211c <panic>
    80002f00:	00195913          	srli	s2,s2,0x1
    80002f04:	fffff097          	auipc	ra,0xfffff
    80002f08:	858080e7          	jalr	-1960(ra) # 8000175c <mycpu>
    80002f0c:	00197913          	andi	s2,s2,1
    80002f10:	07252e23          	sw	s2,124(a0)
    80002f14:	f75ff06f          	j	80002e88 <acquire+0x3c>

0000000080002f18 <release>:
    80002f18:	fe010113          	addi	sp,sp,-32
    80002f1c:	00813823          	sd	s0,16(sp)
    80002f20:	00113c23          	sd	ra,24(sp)
    80002f24:	00913423          	sd	s1,8(sp)
    80002f28:	01213023          	sd	s2,0(sp)
    80002f2c:	02010413          	addi	s0,sp,32
    80002f30:	00052783          	lw	a5,0(a0)
    80002f34:	00079a63          	bnez	a5,80002f48 <release+0x30>
    80002f38:	00001517          	auipc	a0,0x1
    80002f3c:	27850513          	addi	a0,a0,632 # 800041b0 <digits+0x28>
    80002f40:	fffff097          	auipc	ra,0xfffff
    80002f44:	1dc080e7          	jalr	476(ra) # 8000211c <panic>
    80002f48:	01053903          	ld	s2,16(a0)
    80002f4c:	00050493          	mv	s1,a0
    80002f50:	fffff097          	auipc	ra,0xfffff
    80002f54:	80c080e7          	jalr	-2036(ra) # 8000175c <mycpu>
    80002f58:	fea910e3          	bne	s2,a0,80002f38 <release+0x20>
    80002f5c:	0004b823          	sd	zero,16(s1)
    80002f60:	0ff0000f          	fence
    80002f64:	0f50000f          	fence	iorw,ow
    80002f68:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002f6c:	ffffe097          	auipc	ra,0xffffe
    80002f70:	7f0080e7          	jalr	2032(ra) # 8000175c <mycpu>
    80002f74:	100027f3          	csrr	a5,sstatus
    80002f78:	0027f793          	andi	a5,a5,2
    80002f7c:	04079a63          	bnez	a5,80002fd0 <release+0xb8>
    80002f80:	07852783          	lw	a5,120(a0)
    80002f84:	02f05e63          	blez	a5,80002fc0 <release+0xa8>
    80002f88:	fff7871b          	addiw	a4,a5,-1
    80002f8c:	06e52c23          	sw	a4,120(a0)
    80002f90:	00071c63          	bnez	a4,80002fa8 <release+0x90>
    80002f94:	07c52783          	lw	a5,124(a0)
    80002f98:	00078863          	beqz	a5,80002fa8 <release+0x90>
    80002f9c:	100027f3          	csrr	a5,sstatus
    80002fa0:	0027e793          	ori	a5,a5,2
    80002fa4:	10079073          	csrw	sstatus,a5
    80002fa8:	01813083          	ld	ra,24(sp)
    80002fac:	01013403          	ld	s0,16(sp)
    80002fb0:	00813483          	ld	s1,8(sp)
    80002fb4:	00013903          	ld	s2,0(sp)
    80002fb8:	02010113          	addi	sp,sp,32
    80002fbc:	00008067          	ret
    80002fc0:	00001517          	auipc	a0,0x1
    80002fc4:	21050513          	addi	a0,a0,528 # 800041d0 <digits+0x48>
    80002fc8:	fffff097          	auipc	ra,0xfffff
    80002fcc:	154080e7          	jalr	340(ra) # 8000211c <panic>
    80002fd0:	00001517          	auipc	a0,0x1
    80002fd4:	1e850513          	addi	a0,a0,488 # 800041b8 <digits+0x30>
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	144080e7          	jalr	324(ra) # 8000211c <panic>

0000000080002fe0 <holding>:
    80002fe0:	00052783          	lw	a5,0(a0)
    80002fe4:	00079663          	bnez	a5,80002ff0 <holding+0x10>
    80002fe8:	00000513          	li	a0,0
    80002fec:	00008067          	ret
    80002ff0:	fe010113          	addi	sp,sp,-32
    80002ff4:	00813823          	sd	s0,16(sp)
    80002ff8:	00913423          	sd	s1,8(sp)
    80002ffc:	00113c23          	sd	ra,24(sp)
    80003000:	02010413          	addi	s0,sp,32
    80003004:	01053483          	ld	s1,16(a0)
    80003008:	ffffe097          	auipc	ra,0xffffe
    8000300c:	754080e7          	jalr	1876(ra) # 8000175c <mycpu>
    80003010:	01813083          	ld	ra,24(sp)
    80003014:	01013403          	ld	s0,16(sp)
    80003018:	40a48533          	sub	a0,s1,a0
    8000301c:	00153513          	seqz	a0,a0
    80003020:	00813483          	ld	s1,8(sp)
    80003024:	02010113          	addi	sp,sp,32
    80003028:	00008067          	ret

000000008000302c <push_off>:
    8000302c:	fe010113          	addi	sp,sp,-32
    80003030:	00813823          	sd	s0,16(sp)
    80003034:	00113c23          	sd	ra,24(sp)
    80003038:	00913423          	sd	s1,8(sp)
    8000303c:	02010413          	addi	s0,sp,32
    80003040:	100024f3          	csrr	s1,sstatus
    80003044:	100027f3          	csrr	a5,sstatus
    80003048:	ffd7f793          	andi	a5,a5,-3
    8000304c:	10079073          	csrw	sstatus,a5
    80003050:	ffffe097          	auipc	ra,0xffffe
    80003054:	70c080e7          	jalr	1804(ra) # 8000175c <mycpu>
    80003058:	07852783          	lw	a5,120(a0)
    8000305c:	02078663          	beqz	a5,80003088 <push_off+0x5c>
    80003060:	ffffe097          	auipc	ra,0xffffe
    80003064:	6fc080e7          	jalr	1788(ra) # 8000175c <mycpu>
    80003068:	07852783          	lw	a5,120(a0)
    8000306c:	01813083          	ld	ra,24(sp)
    80003070:	01013403          	ld	s0,16(sp)
    80003074:	0017879b          	addiw	a5,a5,1
    80003078:	06f52c23          	sw	a5,120(a0)
    8000307c:	00813483          	ld	s1,8(sp)
    80003080:	02010113          	addi	sp,sp,32
    80003084:	00008067          	ret
    80003088:	0014d493          	srli	s1,s1,0x1
    8000308c:	ffffe097          	auipc	ra,0xffffe
    80003090:	6d0080e7          	jalr	1744(ra) # 8000175c <mycpu>
    80003094:	0014f493          	andi	s1,s1,1
    80003098:	06952e23          	sw	s1,124(a0)
    8000309c:	fc5ff06f          	j	80003060 <push_off+0x34>

00000000800030a0 <pop_off>:
    800030a0:	ff010113          	addi	sp,sp,-16
    800030a4:	00813023          	sd	s0,0(sp)
    800030a8:	00113423          	sd	ra,8(sp)
    800030ac:	01010413          	addi	s0,sp,16
    800030b0:	ffffe097          	auipc	ra,0xffffe
    800030b4:	6ac080e7          	jalr	1708(ra) # 8000175c <mycpu>
    800030b8:	100027f3          	csrr	a5,sstatus
    800030bc:	0027f793          	andi	a5,a5,2
    800030c0:	04079663          	bnez	a5,8000310c <pop_off+0x6c>
    800030c4:	07852783          	lw	a5,120(a0)
    800030c8:	02f05a63          	blez	a5,800030fc <pop_off+0x5c>
    800030cc:	fff7871b          	addiw	a4,a5,-1
    800030d0:	06e52c23          	sw	a4,120(a0)
    800030d4:	00071c63          	bnez	a4,800030ec <pop_off+0x4c>
    800030d8:	07c52783          	lw	a5,124(a0)
    800030dc:	00078863          	beqz	a5,800030ec <pop_off+0x4c>
    800030e0:	100027f3          	csrr	a5,sstatus
    800030e4:	0027e793          	ori	a5,a5,2
    800030e8:	10079073          	csrw	sstatus,a5
    800030ec:	00813083          	ld	ra,8(sp)
    800030f0:	00013403          	ld	s0,0(sp)
    800030f4:	01010113          	addi	sp,sp,16
    800030f8:	00008067          	ret
    800030fc:	00001517          	auipc	a0,0x1
    80003100:	0d450513          	addi	a0,a0,212 # 800041d0 <digits+0x48>
    80003104:	fffff097          	auipc	ra,0xfffff
    80003108:	018080e7          	jalr	24(ra) # 8000211c <panic>
    8000310c:	00001517          	auipc	a0,0x1
    80003110:	0ac50513          	addi	a0,a0,172 # 800041b8 <digits+0x30>
    80003114:	fffff097          	auipc	ra,0xfffff
    80003118:	008080e7          	jalr	8(ra) # 8000211c <panic>

000000008000311c <push_on>:
    8000311c:	fe010113          	addi	sp,sp,-32
    80003120:	00813823          	sd	s0,16(sp)
    80003124:	00113c23          	sd	ra,24(sp)
    80003128:	00913423          	sd	s1,8(sp)
    8000312c:	02010413          	addi	s0,sp,32
    80003130:	100024f3          	csrr	s1,sstatus
    80003134:	100027f3          	csrr	a5,sstatus
    80003138:	0027e793          	ori	a5,a5,2
    8000313c:	10079073          	csrw	sstatus,a5
    80003140:	ffffe097          	auipc	ra,0xffffe
    80003144:	61c080e7          	jalr	1564(ra) # 8000175c <mycpu>
    80003148:	07852783          	lw	a5,120(a0)
    8000314c:	02078663          	beqz	a5,80003178 <push_on+0x5c>
    80003150:	ffffe097          	auipc	ra,0xffffe
    80003154:	60c080e7          	jalr	1548(ra) # 8000175c <mycpu>
    80003158:	07852783          	lw	a5,120(a0)
    8000315c:	01813083          	ld	ra,24(sp)
    80003160:	01013403          	ld	s0,16(sp)
    80003164:	0017879b          	addiw	a5,a5,1
    80003168:	06f52c23          	sw	a5,120(a0)
    8000316c:	00813483          	ld	s1,8(sp)
    80003170:	02010113          	addi	sp,sp,32
    80003174:	00008067          	ret
    80003178:	0014d493          	srli	s1,s1,0x1
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	5e0080e7          	jalr	1504(ra) # 8000175c <mycpu>
    80003184:	0014f493          	andi	s1,s1,1
    80003188:	06952e23          	sw	s1,124(a0)
    8000318c:	fc5ff06f          	j	80003150 <push_on+0x34>

0000000080003190 <pop_on>:
    80003190:	ff010113          	addi	sp,sp,-16
    80003194:	00813023          	sd	s0,0(sp)
    80003198:	00113423          	sd	ra,8(sp)
    8000319c:	01010413          	addi	s0,sp,16
    800031a0:	ffffe097          	auipc	ra,0xffffe
    800031a4:	5bc080e7          	jalr	1468(ra) # 8000175c <mycpu>
    800031a8:	100027f3          	csrr	a5,sstatus
    800031ac:	0027f793          	andi	a5,a5,2
    800031b0:	04078463          	beqz	a5,800031f8 <pop_on+0x68>
    800031b4:	07852783          	lw	a5,120(a0)
    800031b8:	02f05863          	blez	a5,800031e8 <pop_on+0x58>
    800031bc:	fff7879b          	addiw	a5,a5,-1
    800031c0:	06f52c23          	sw	a5,120(a0)
    800031c4:	07853783          	ld	a5,120(a0)
    800031c8:	00079863          	bnez	a5,800031d8 <pop_on+0x48>
    800031cc:	100027f3          	csrr	a5,sstatus
    800031d0:	ffd7f793          	andi	a5,a5,-3
    800031d4:	10079073          	csrw	sstatus,a5
    800031d8:	00813083          	ld	ra,8(sp)
    800031dc:	00013403          	ld	s0,0(sp)
    800031e0:	01010113          	addi	sp,sp,16
    800031e4:	00008067          	ret
    800031e8:	00001517          	auipc	a0,0x1
    800031ec:	01050513          	addi	a0,a0,16 # 800041f8 <digits+0x70>
    800031f0:	fffff097          	auipc	ra,0xfffff
    800031f4:	f2c080e7          	jalr	-212(ra) # 8000211c <panic>
    800031f8:	00001517          	auipc	a0,0x1
    800031fc:	fe050513          	addi	a0,a0,-32 # 800041d8 <digits+0x50>
    80003200:	fffff097          	auipc	ra,0xfffff
    80003204:	f1c080e7          	jalr	-228(ra) # 8000211c <panic>

0000000080003208 <__memset>:
    80003208:	ff010113          	addi	sp,sp,-16
    8000320c:	00813423          	sd	s0,8(sp)
    80003210:	01010413          	addi	s0,sp,16
    80003214:	1a060e63          	beqz	a2,800033d0 <__memset+0x1c8>
    80003218:	40a007b3          	neg	a5,a0
    8000321c:	0077f793          	andi	a5,a5,7
    80003220:	00778693          	addi	a3,a5,7
    80003224:	00b00813          	li	a6,11
    80003228:	0ff5f593          	andi	a1,a1,255
    8000322c:	fff6071b          	addiw	a4,a2,-1
    80003230:	1b06e663          	bltu	a3,a6,800033dc <__memset+0x1d4>
    80003234:	1cd76463          	bltu	a4,a3,800033fc <__memset+0x1f4>
    80003238:	1a078e63          	beqz	a5,800033f4 <__memset+0x1ec>
    8000323c:	00b50023          	sb	a1,0(a0)
    80003240:	00100713          	li	a4,1
    80003244:	1ae78463          	beq	a5,a4,800033ec <__memset+0x1e4>
    80003248:	00b500a3          	sb	a1,1(a0)
    8000324c:	00200713          	li	a4,2
    80003250:	1ae78a63          	beq	a5,a4,80003404 <__memset+0x1fc>
    80003254:	00b50123          	sb	a1,2(a0)
    80003258:	00300713          	li	a4,3
    8000325c:	18e78463          	beq	a5,a4,800033e4 <__memset+0x1dc>
    80003260:	00b501a3          	sb	a1,3(a0)
    80003264:	00400713          	li	a4,4
    80003268:	1ae78263          	beq	a5,a4,8000340c <__memset+0x204>
    8000326c:	00b50223          	sb	a1,4(a0)
    80003270:	00500713          	li	a4,5
    80003274:	1ae78063          	beq	a5,a4,80003414 <__memset+0x20c>
    80003278:	00b502a3          	sb	a1,5(a0)
    8000327c:	00700713          	li	a4,7
    80003280:	18e79e63          	bne	a5,a4,8000341c <__memset+0x214>
    80003284:	00b50323          	sb	a1,6(a0)
    80003288:	00700e93          	li	t4,7
    8000328c:	00859713          	slli	a4,a1,0x8
    80003290:	00e5e733          	or	a4,a1,a4
    80003294:	01059e13          	slli	t3,a1,0x10
    80003298:	01c76e33          	or	t3,a4,t3
    8000329c:	01859313          	slli	t1,a1,0x18
    800032a0:	006e6333          	or	t1,t3,t1
    800032a4:	02059893          	slli	a7,a1,0x20
    800032a8:	40f60e3b          	subw	t3,a2,a5
    800032ac:	011368b3          	or	a7,t1,a7
    800032b0:	02859813          	slli	a6,a1,0x28
    800032b4:	0108e833          	or	a6,a7,a6
    800032b8:	03059693          	slli	a3,a1,0x30
    800032bc:	003e589b          	srliw	a7,t3,0x3
    800032c0:	00d866b3          	or	a3,a6,a3
    800032c4:	03859713          	slli	a4,a1,0x38
    800032c8:	00389813          	slli	a6,a7,0x3
    800032cc:	00f507b3          	add	a5,a0,a5
    800032d0:	00e6e733          	or	a4,a3,a4
    800032d4:	000e089b          	sext.w	a7,t3
    800032d8:	00f806b3          	add	a3,a6,a5
    800032dc:	00e7b023          	sd	a4,0(a5)
    800032e0:	00878793          	addi	a5,a5,8
    800032e4:	fed79ce3          	bne	a5,a3,800032dc <__memset+0xd4>
    800032e8:	ff8e7793          	andi	a5,t3,-8
    800032ec:	0007871b          	sext.w	a4,a5
    800032f0:	01d787bb          	addw	a5,a5,t4
    800032f4:	0ce88e63          	beq	a7,a4,800033d0 <__memset+0x1c8>
    800032f8:	00f50733          	add	a4,a0,a5
    800032fc:	00b70023          	sb	a1,0(a4)
    80003300:	0017871b          	addiw	a4,a5,1
    80003304:	0cc77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003308:	00e50733          	add	a4,a0,a4
    8000330c:	00b70023          	sb	a1,0(a4)
    80003310:	0027871b          	addiw	a4,a5,2
    80003314:	0ac77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003318:	00e50733          	add	a4,a0,a4
    8000331c:	00b70023          	sb	a1,0(a4)
    80003320:	0037871b          	addiw	a4,a5,3
    80003324:	0ac77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003328:	00e50733          	add	a4,a0,a4
    8000332c:	00b70023          	sb	a1,0(a4)
    80003330:	0047871b          	addiw	a4,a5,4
    80003334:	08c77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003338:	00e50733          	add	a4,a0,a4
    8000333c:	00b70023          	sb	a1,0(a4)
    80003340:	0057871b          	addiw	a4,a5,5
    80003344:	08c77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003348:	00e50733          	add	a4,a0,a4
    8000334c:	00b70023          	sb	a1,0(a4)
    80003350:	0067871b          	addiw	a4,a5,6
    80003354:	06c77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003358:	00e50733          	add	a4,a0,a4
    8000335c:	00b70023          	sb	a1,0(a4)
    80003360:	0077871b          	addiw	a4,a5,7
    80003364:	06c77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003368:	00e50733          	add	a4,a0,a4
    8000336c:	00b70023          	sb	a1,0(a4)
    80003370:	0087871b          	addiw	a4,a5,8
    80003374:	04c77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003378:	00e50733          	add	a4,a0,a4
    8000337c:	00b70023          	sb	a1,0(a4)
    80003380:	0097871b          	addiw	a4,a5,9
    80003384:	04c77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003388:	00e50733          	add	a4,a0,a4
    8000338c:	00b70023          	sb	a1,0(a4)
    80003390:	00a7871b          	addiw	a4,a5,10
    80003394:	02c77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    80003398:	00e50733          	add	a4,a0,a4
    8000339c:	00b70023          	sb	a1,0(a4)
    800033a0:	00b7871b          	addiw	a4,a5,11
    800033a4:	02c77663          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    800033a8:	00e50733          	add	a4,a0,a4
    800033ac:	00b70023          	sb	a1,0(a4)
    800033b0:	00c7871b          	addiw	a4,a5,12
    800033b4:	00c77e63          	bgeu	a4,a2,800033d0 <__memset+0x1c8>
    800033b8:	00e50733          	add	a4,a0,a4
    800033bc:	00b70023          	sb	a1,0(a4)
    800033c0:	00d7879b          	addiw	a5,a5,13
    800033c4:	00c7f663          	bgeu	a5,a2,800033d0 <__memset+0x1c8>
    800033c8:	00f507b3          	add	a5,a0,a5
    800033cc:	00b78023          	sb	a1,0(a5)
    800033d0:	00813403          	ld	s0,8(sp)
    800033d4:	01010113          	addi	sp,sp,16
    800033d8:	00008067          	ret
    800033dc:	00b00693          	li	a3,11
    800033e0:	e55ff06f          	j	80003234 <__memset+0x2c>
    800033e4:	00300e93          	li	t4,3
    800033e8:	ea5ff06f          	j	8000328c <__memset+0x84>
    800033ec:	00100e93          	li	t4,1
    800033f0:	e9dff06f          	j	8000328c <__memset+0x84>
    800033f4:	00000e93          	li	t4,0
    800033f8:	e95ff06f          	j	8000328c <__memset+0x84>
    800033fc:	00000793          	li	a5,0
    80003400:	ef9ff06f          	j	800032f8 <__memset+0xf0>
    80003404:	00200e93          	li	t4,2
    80003408:	e85ff06f          	j	8000328c <__memset+0x84>
    8000340c:	00400e93          	li	t4,4
    80003410:	e7dff06f          	j	8000328c <__memset+0x84>
    80003414:	00500e93          	li	t4,5
    80003418:	e75ff06f          	j	8000328c <__memset+0x84>
    8000341c:	00600e93          	li	t4,6
    80003420:	e6dff06f          	j	8000328c <__memset+0x84>

0000000080003424 <__memmove>:
    80003424:	ff010113          	addi	sp,sp,-16
    80003428:	00813423          	sd	s0,8(sp)
    8000342c:	01010413          	addi	s0,sp,16
    80003430:	0e060863          	beqz	a2,80003520 <__memmove+0xfc>
    80003434:	fff6069b          	addiw	a3,a2,-1
    80003438:	0006881b          	sext.w	a6,a3
    8000343c:	0ea5e863          	bltu	a1,a0,8000352c <__memmove+0x108>
    80003440:	00758713          	addi	a4,a1,7
    80003444:	00a5e7b3          	or	a5,a1,a0
    80003448:	40a70733          	sub	a4,a4,a0
    8000344c:	0077f793          	andi	a5,a5,7
    80003450:	00f73713          	sltiu	a4,a4,15
    80003454:	00174713          	xori	a4,a4,1
    80003458:	0017b793          	seqz	a5,a5
    8000345c:	00e7f7b3          	and	a5,a5,a4
    80003460:	10078863          	beqz	a5,80003570 <__memmove+0x14c>
    80003464:	00900793          	li	a5,9
    80003468:	1107f463          	bgeu	a5,a6,80003570 <__memmove+0x14c>
    8000346c:	0036581b          	srliw	a6,a2,0x3
    80003470:	fff8081b          	addiw	a6,a6,-1
    80003474:	02081813          	slli	a6,a6,0x20
    80003478:	01d85893          	srli	a7,a6,0x1d
    8000347c:	00858813          	addi	a6,a1,8
    80003480:	00058793          	mv	a5,a1
    80003484:	00050713          	mv	a4,a0
    80003488:	01088833          	add	a6,a7,a6
    8000348c:	0007b883          	ld	a7,0(a5)
    80003490:	00878793          	addi	a5,a5,8
    80003494:	00870713          	addi	a4,a4,8
    80003498:	ff173c23          	sd	a7,-8(a4)
    8000349c:	ff0798e3          	bne	a5,a6,8000348c <__memmove+0x68>
    800034a0:	ff867713          	andi	a4,a2,-8
    800034a4:	02071793          	slli	a5,a4,0x20
    800034a8:	0207d793          	srli	a5,a5,0x20
    800034ac:	00f585b3          	add	a1,a1,a5
    800034b0:	40e686bb          	subw	a3,a3,a4
    800034b4:	00f507b3          	add	a5,a0,a5
    800034b8:	06e60463          	beq	a2,a4,80003520 <__memmove+0xfc>
    800034bc:	0005c703          	lbu	a4,0(a1)
    800034c0:	00e78023          	sb	a4,0(a5)
    800034c4:	04068e63          	beqz	a3,80003520 <__memmove+0xfc>
    800034c8:	0015c603          	lbu	a2,1(a1)
    800034cc:	00100713          	li	a4,1
    800034d0:	00c780a3          	sb	a2,1(a5)
    800034d4:	04e68663          	beq	a3,a4,80003520 <__memmove+0xfc>
    800034d8:	0025c603          	lbu	a2,2(a1)
    800034dc:	00200713          	li	a4,2
    800034e0:	00c78123          	sb	a2,2(a5)
    800034e4:	02e68e63          	beq	a3,a4,80003520 <__memmove+0xfc>
    800034e8:	0035c603          	lbu	a2,3(a1)
    800034ec:	00300713          	li	a4,3
    800034f0:	00c781a3          	sb	a2,3(a5)
    800034f4:	02e68663          	beq	a3,a4,80003520 <__memmove+0xfc>
    800034f8:	0045c603          	lbu	a2,4(a1)
    800034fc:	00400713          	li	a4,4
    80003500:	00c78223          	sb	a2,4(a5)
    80003504:	00e68e63          	beq	a3,a4,80003520 <__memmove+0xfc>
    80003508:	0055c603          	lbu	a2,5(a1)
    8000350c:	00500713          	li	a4,5
    80003510:	00c782a3          	sb	a2,5(a5)
    80003514:	00e68663          	beq	a3,a4,80003520 <__memmove+0xfc>
    80003518:	0065c703          	lbu	a4,6(a1)
    8000351c:	00e78323          	sb	a4,6(a5)
    80003520:	00813403          	ld	s0,8(sp)
    80003524:	01010113          	addi	sp,sp,16
    80003528:	00008067          	ret
    8000352c:	02061713          	slli	a4,a2,0x20
    80003530:	02075713          	srli	a4,a4,0x20
    80003534:	00e587b3          	add	a5,a1,a4
    80003538:	f0f574e3          	bgeu	a0,a5,80003440 <__memmove+0x1c>
    8000353c:	02069613          	slli	a2,a3,0x20
    80003540:	02065613          	srli	a2,a2,0x20
    80003544:	fff64613          	not	a2,a2
    80003548:	00e50733          	add	a4,a0,a4
    8000354c:	00c78633          	add	a2,a5,a2
    80003550:	fff7c683          	lbu	a3,-1(a5)
    80003554:	fff78793          	addi	a5,a5,-1
    80003558:	fff70713          	addi	a4,a4,-1
    8000355c:	00d70023          	sb	a3,0(a4)
    80003560:	fec798e3          	bne	a5,a2,80003550 <__memmove+0x12c>
    80003564:	00813403          	ld	s0,8(sp)
    80003568:	01010113          	addi	sp,sp,16
    8000356c:	00008067          	ret
    80003570:	02069713          	slli	a4,a3,0x20
    80003574:	02075713          	srli	a4,a4,0x20
    80003578:	00170713          	addi	a4,a4,1
    8000357c:	00e50733          	add	a4,a0,a4
    80003580:	00050793          	mv	a5,a0
    80003584:	0005c683          	lbu	a3,0(a1)
    80003588:	00178793          	addi	a5,a5,1
    8000358c:	00158593          	addi	a1,a1,1
    80003590:	fed78fa3          	sb	a3,-1(a5)
    80003594:	fee798e3          	bne	a5,a4,80003584 <__memmove+0x160>
    80003598:	f89ff06f          	j	80003520 <__memmove+0xfc>

000000008000359c <__putc>:
    8000359c:	fe010113          	addi	sp,sp,-32
    800035a0:	00813823          	sd	s0,16(sp)
    800035a4:	00113c23          	sd	ra,24(sp)
    800035a8:	02010413          	addi	s0,sp,32
    800035ac:	00050793          	mv	a5,a0
    800035b0:	fef40593          	addi	a1,s0,-17
    800035b4:	00100613          	li	a2,1
    800035b8:	00000513          	li	a0,0
    800035bc:	fef407a3          	sb	a5,-17(s0)
    800035c0:	fffff097          	auipc	ra,0xfffff
    800035c4:	b3c080e7          	jalr	-1220(ra) # 800020fc <console_write>
    800035c8:	01813083          	ld	ra,24(sp)
    800035cc:	01013403          	ld	s0,16(sp)
    800035d0:	02010113          	addi	sp,sp,32
    800035d4:	00008067          	ret

00000000800035d8 <__getc>:
    800035d8:	fe010113          	addi	sp,sp,-32
    800035dc:	00813823          	sd	s0,16(sp)
    800035e0:	00113c23          	sd	ra,24(sp)
    800035e4:	02010413          	addi	s0,sp,32
    800035e8:	fe840593          	addi	a1,s0,-24
    800035ec:	00100613          	li	a2,1
    800035f0:	00000513          	li	a0,0
    800035f4:	fffff097          	auipc	ra,0xfffff
    800035f8:	ae8080e7          	jalr	-1304(ra) # 800020dc <console_read>
    800035fc:	fe844503          	lbu	a0,-24(s0)
    80003600:	01813083          	ld	ra,24(sp)
    80003604:	01013403          	ld	s0,16(sp)
    80003608:	02010113          	addi	sp,sp,32
    8000360c:	00008067          	ret

0000000080003610 <console_handler>:
    80003610:	fe010113          	addi	sp,sp,-32
    80003614:	00813823          	sd	s0,16(sp)
    80003618:	00113c23          	sd	ra,24(sp)
    8000361c:	00913423          	sd	s1,8(sp)
    80003620:	02010413          	addi	s0,sp,32
    80003624:	14202773          	csrr	a4,scause
    80003628:	100027f3          	csrr	a5,sstatus
    8000362c:	0027f793          	andi	a5,a5,2
    80003630:	06079e63          	bnez	a5,800036ac <console_handler+0x9c>
    80003634:	00074c63          	bltz	a4,8000364c <console_handler+0x3c>
    80003638:	01813083          	ld	ra,24(sp)
    8000363c:	01013403          	ld	s0,16(sp)
    80003640:	00813483          	ld	s1,8(sp)
    80003644:	02010113          	addi	sp,sp,32
    80003648:	00008067          	ret
    8000364c:	0ff77713          	andi	a4,a4,255
    80003650:	00900793          	li	a5,9
    80003654:	fef712e3          	bne	a4,a5,80003638 <console_handler+0x28>
    80003658:	ffffe097          	auipc	ra,0xffffe
    8000365c:	6dc080e7          	jalr	1756(ra) # 80001d34 <plic_claim>
    80003660:	00a00793          	li	a5,10
    80003664:	00050493          	mv	s1,a0
    80003668:	02f50c63          	beq	a0,a5,800036a0 <console_handler+0x90>
    8000366c:	fc0506e3          	beqz	a0,80003638 <console_handler+0x28>
    80003670:	00050593          	mv	a1,a0
    80003674:	00001517          	auipc	a0,0x1
    80003678:	a8c50513          	addi	a0,a0,-1396 # 80004100 <_ZZ12printIntegermE6digits+0xe0>
    8000367c:	fffff097          	auipc	ra,0xfffff
    80003680:	afc080e7          	jalr	-1284(ra) # 80002178 <__printf>
    80003684:	01013403          	ld	s0,16(sp)
    80003688:	01813083          	ld	ra,24(sp)
    8000368c:	00048513          	mv	a0,s1
    80003690:	00813483          	ld	s1,8(sp)
    80003694:	02010113          	addi	sp,sp,32
    80003698:	ffffe317          	auipc	t1,0xffffe
    8000369c:	6d430067          	jr	1748(t1) # 80001d6c <plic_complete>
    800036a0:	fffff097          	auipc	ra,0xfffff
    800036a4:	3e0080e7          	jalr	992(ra) # 80002a80 <uartintr>
    800036a8:	fddff06f          	j	80003684 <console_handler+0x74>
    800036ac:	00001517          	auipc	a0,0x1
    800036b0:	b5450513          	addi	a0,a0,-1196 # 80004200 <digits+0x78>
    800036b4:	fffff097          	auipc	ra,0xfffff
    800036b8:	a68080e7          	jalr	-1432(ra) # 8000211c <panic>
	...
