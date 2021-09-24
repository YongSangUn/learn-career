import random


def bubbleSortA(nums):
    N = len(nums)
    for i in range(N - 1):
        a, b = 0, 1
        while b <= N - 1 - i:
            if nums[a] > nums[b]:
                nums[a], nums[b] = nums[b], nums[a]
            a, b = a + 1, b + 1
    return nums


def bubbleSortB(nums):
    unsortIndex = len(nums) - 1
    sorted = False
    while not sorted:
        sorted = True
        for i in range(unsortIndex):
            if nums[i] > nums[i + 1]:
                nums[i], nums[i + 1] = nums[i + 1], nums[i]
                sorted = False
        unsortIndex = unsortIndex - 1
    return nums


def selectionSort(nums):
    N = len(nums)
    for i in range(N):
        minIndex = i
        for j in range(i + 1, N):
            if nums[j] < nums[minIndex]:
                minIndex = j
        if minIndex != i:
            nums[i], nums[minIndex] = nums[minIndex], nums[i]
    return nums


def insertionSort(nums):
    N = len(nums)
    for i in range(1, N):
        j, tmp = i, nums[i]
        while j > 0 and nums[j - 1] > tmp:
            nums[j] = nums[j - 1]
            j = j - 1
        nums[j] = tmp
    return nums


if __name__ == "__main__":
    nums = [random.randint(0, 100) for i in range(random.randint(2, 30))]
    print(nums)
    print(bubbleSortA(nums))
    print(bubbleSortB(nums))
    print(selectionSort(nums))
    print(insertionSort(nums))
