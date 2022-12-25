#include <stdio.h>
#include <string.h>
#define TOTAL_CHARS 256 // Total 256 characters can be there
int max(int a, int b) { return (a > b) ? a : b; }
void badCharacterHeuristic(char* STR, int size, int badcharacter[TOTAL_CHARS])
{
    for (int i = 0; i < TOTAL_CHARS; i++) // Initialize all occurrences as -1
        badcharacter[i] = -1;
     // Put the value of last last occurrence of the character
    for (int i = 0; i < size; i++)
        badcharacter[(int)STR[i]] = i;
 }
 // Boyer Moore bad character approach
void Bad_Character_Search(char* text, char* pattern)
{
    int m = strlen(pattern);
    int n = strlen(text);
    int badcharacter[TOTAL_CHARS];
    badCharacterHeuristic(pattern, m, badcharacter); // Preprocess by filling bad character
    int shift = 0;
    while (shift <= (n - m)) // Shift until end of text
    {
        int j = m - 1;
        while (j >= 0 && pattern[j] == text[shift + j]) /* j  decreases until characters of pattern and text are match at the current shift */
            j--;
        if (j < 0) // It indicates pattern is there at current shift position
        {
            printf("pattern occurs at shift = %d", shift);
             /* The case shift + m < n is mandate to handle the pattern at end of text */
            shift += (shift + m < n) ? m - badcharacter[text[shift + m]] : 1;
        }
         else
             /* maximum function gives a positive shift . There are possible cases
                         to get a negative shift value if last occurrence of bad character is on right of current one */
            shift += max(1, j - badcharacter[text[shift + j]]);
    }
}
// Main function to run bad character approach

int main()
{
    char text[] = "ABAAABCD";
    char pattern[] = "ABC";
    Bad_Character_Search(text, pattern);
    return 0;
} 