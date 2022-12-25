import numpy as np
def encryption(matrix):
    matrix= matrix.replace(" ", "")
    C = make_key()
    length_check = len(matrix) % 2 == 0
    if not length_check:
        matrix += "0"
    P = stringmatrix(matrix)
    message_length = int(len(matrix) / 2)
    encryptionmatrix = ""
    for i in range(message_length):
        row_0 = P[0][i] * C[0][0] + P[1][i] * C[0][1]
        integer = int(row_0 % 26 + 65)
        encryptionmatrix += chr(integer)
        row_1 = P[0][i] * C[1][0] + P[1][i] * C[1][1]
        integer = int(row_1 % 26 + 65)
        encryptionmatrix += chr(integer)
    return encryptionmatrix

def decryption(encryptionmatrix):
    C = make_key()
    determinant = C[0][0] * C[1][1] - C[0][1] * C[1][0]
    determinant = determinant % 26
    multiplicative_inverse = inverse(determinant)
    C_inverse = C
    C_inverse[0][0], C_inverse[1][1] = C_inverse[1, 1], C_inverse[0, 0]
    C[0][1] *= -1
    C[1][0] *= -1
    for row in range(2):
        for column in range(2):
            C_inverse[row][column] *= multiplicative_inverse
            C_inverse[row][column] = C_inverse[row][column] % 26

    P = stringmatrix(encryptionmatrix)
    m_len = int(len(encryptionmatrix) / 2)
    decryption_matrix = ""
    for i in range(m_len):
        column_0 = P[0][i] * C_inverse[0][0] + P[1][i] * C_inverse[0][1]
        integer = int(column_0 % 26 + 65)
        decryption_matrix += chr(integer)
        column_1 = P[0][i] * C_inverse[1][0] + P[1][i] * C_inverse[1][1]
        integer = int(column_1 % 26 + 65)
        decryption_matrix += chr(integer)
    if decryption_matrix[-1] == "0":
        decryption_matrix = decryption_matrix[:-1]
    return decryption_matrix

def inverse(determinant):
    multiplicative_inverse = -1
    for i in range(26):
        inverse = determinant * i
        if inverse % 26 == 1:
            multiplicative_inverse = i
            break
    return multiplicative_inverse


def make_key():
    determinant = 0
    C = None
    while True:
        cipher = input("Input 4 letter cipher: ")
        C = stringmatrix(cipher)
        determinant = C[0][0] * C[1][1] - C[0][1] * C[1][0]
        determinant = determinant % 26
        inverse_element = inverse(determinant)
        if inverse_element == -1:
            print("Determinant is not relatively prime to 26, uninvertible key")
        elif np.amax(C) > 26 and np.amin(C) < 0:
            print("Only a-z characters are accepted")
            print(np.amax(C), np.amin(C))
        else:
            break
    return C

def stringmatrix(string):
    integers = [chr_to_int(c) for c in string]
    length = len(integers)
    M = np.zeros((2, int(length / 2)), dtype=np.int32)
    iterator = 0
    for column in range(int(length / 2)):
        for row in range(2):
            M[row][column] = integers[iterator]
            iterator += 1
    return M

def chr_to_int(char):
    char = char.upper()
    integer = ord(char) - 65
    return integer

if __name__ == "__main__":
    m = input("Message: ")
    encryptionmatrix = encryption(m)
    print(encryptionmatrix)
    decryption_matrix = decryption(encryptionmatrix)
    print(decryption_matrix)