# AES-128-
Advanced encryption standard implementation in Verilog.

ADVANCED ENCRYPTION STANDARD [128-BIT CTR MODE].

The Encryption process consists of different steps after taking the plaintext and the encryption key as an input it expands the key to 10 different keys and runs the plaintext through cycles of 4 functions to produce the final cipher.

![image](https://github.com/mohos455/AES-128-/assets/106884579/2b46e5a2-2919-4415-ad7d-5b431e3bfa39)

SUB BYTES
Each byte is replaced by a byte from the previously generated S-Box.

KEY EXPANSION
The key expansion function takes the user supplied 16 bytes long key and utilizes round constant matrix rcon and the substitution table s_box to generate the next key to be used in the next cycle of encryption.

ADD ROUND KEY
A bitwise xor of the state matrix and the cycle’s round key matrix.

![image](https://github.com/mohos455/AES-128-/assets/106884579/e20840d2-3c04-40d0-a80b-a133af4e0e6e)


SHIFT ROWS
Each row is rotated to the left. The second row is rotated once, second row twice and third row three times.

![image](https://github.com/mohos455/AES-128-/assets/106884579/16a36c56-91bb-4a8d-99e5-8ee2466c2f15)


MIX COLUMNS
In this step we compute the new state matrix by left-multiplying the current state matrix by the polynomial matrix P.

![image](https://github.com/mohos455/AES-128-/assets/106884579/2e5e14a8-e632-423e-a6d6-fddc52f1f867)

Pseudo Code for the Cipher

![image](https://github.com/mohos455/AES-128-/assets/106884579/77137291-4c37-476f-84ce-9a7f02b64ff9)

Simulation :
PLAINTEXT: 00112233445566778899aabbccddeeff

KEY: 000102030405060708090a0b0c0d0e0f

round output 69c4e0d86a7b0430d8cdb78070b4c55a

![Screenshot 2023-11-28 180342](https://github.com/mohos455/AES-128-/assets/106884579/41c00c6e-28bb-4b4f-b219-ffce74d9c2aa)


//////

Input =3243f6a8885a308d313198a2e0370734

Cipher Key =2b7e151628aed2a6abf7158809cf4f3c

![Screenshot 2023-11-28 182307](https://github.com/mohos455/AES-128-/assets/106884579/372658b7-c633-42b4-88bf-7183b834fcf6)


Reference :
FIPS 197, Advanced Encryption Standard (AES)

[fips-197.pdf](https://github.com/mohos455/AES-128-/files/13491310/fips-197.pdf) 






