# My Wallet

Assignment project for internship opportunity @Persistent_Ventures

## Getting Started


 #### Requirement
 - New viable account or account in which wallet is not created
 - Android Device or emulator

 #### How to install
 - Download apk-debug from https://github.com/aniketTCodes/My-Wallet/releases/download/complete/app-debug.apk
 - Install the .apk file in Android Device

 #### How to use

- Login to the app using your login credentials

<img src="https://github.com/aniketTCodes/My-Wallet/assets/77580411/64f822f8-2fe5-4c5f-8df9-effdd3e053d0" height=480 width=220>


- Create a new wallet

<img src="https://github.com/aniketTCodes/My-Wallet/assets/77580411/9c1dac88-70f0-4ea3-a767-36e15ddc8606" height=480 width=220>


- Now you can get balance, transfer funds and request airdrop

<img src="https://github.com/aniketTCodes/My-Wallet/assets/77580411/6e43f659-ee73-41b7-ae70-44415eab5007" height=480 width=220>

## API Endpoints

 ### Login
 - POST - https://api.socialverseapp.com/user/login
 - Body - {
    "mixed": "ani962854.at@gmail.com",
    "password": ""
}
 - Response - {
    "status": "success",
    "balance": 0,
    "token": "flic_e0a726f0bfc4cf71382bf449ceab4bcd32bf958bedb6966a1a9d3f71cc5181ae",
    "username": "aniket_00c2i9f6l",
    "email": "ani962854.at@gmail.com",
    "first_name": "Aniket",
    "last_name": "Tiwari",
    "isVerified": false,
    "role": "U",
    "owner_id": "c3pHWk0wQVVZZkNjVC9vc2t2NjdhZz09OjpitS58A38GjzvW7GPwypIs",
    "wallet_address": "0xa17C48A1c1b95005966dc1feC62fBe5812Ce3416",
    "has_wallet": true,
    "last_login": "2024-06-25 11:51:10",
    "profile_picture_url": "https://assets.socialverseapp.com/profile/14.png"
}

### Create Wallet
- Post - {{BaseUrl}}solana/wallet/create
- Body - {
    "wallet_name": "Pooja's Wallet",
    "network": "devnet",
    "user_pin": "123456"
}
- Respone - {
    "status": "success",
    "message": "Wallet created successfully",
    "walletName": "Pooja's Wallet",
    "userPin": "123456",
    "network": "devnet",
    "publicKey": "QTA61YXry54KH5S2qJ6kPRtGt7HWtGag27MJq4nN52g",
    "secretKey": "[191,72,104,141,126,22,243,216,229,63,72,187,85,27,68,129,234,27,74,73,106,59,221,251,119,120,0,211,186,5,123,178,6,1,239,29,66,54,25,69,211,206,248,116,154,243,109,157,126,138,173,164,166,25,18,183,74,189,198,15,63,148,33,105]"
}

### Transfer Balance
- Post - {{BaseUrl}}/solana/wallet/transfer
- Body - {
    "recipient_address": "AxLXd6SsHBHB4HWhRMACuGsuvbtfEq1MsXQqhPaF6wkS",
    "network": "devnet",
    "sender_address": "6LD7oF4QgDaSRwwGGbgUBAZCC3hLNF1PFn6xxDcLKwgA",
    "amount": 130,
    "user_pin": "123456"
}
- Response - {
    "status": "success",
    "message": "Transfer completed successfully",
    "transaction_id": "2Fs1yLvEXuC4HcYoQ7HBf1xkmSYDP7Rg4CJFFqFEH84BZpyv7suy12ty3KK8VpAWCTJ6r9Y5RjufqumeqbWYAJf9"
}

### Get Balance
 - Get - {{BaseUrl}}solana/wallet/balance?network=devnet&wallet_address={{walletAddress}}
 - Response - {
    "status": "success",
    "message": "Ballance fetched successfully",
    "balance": 1000000000
}

### Request Airdrop
- Post - {{BaseUrl}}/solana/wallet/airdrop
- Body - {
    "wallet_address": "2ZQ8YBP8GbttAGvC53Myoy9LEZyqSUccgn5npgZHXgux",
    "network": "devnet",
    "amount": "100"
}
- Response - {
    "status": "error",
    "message": "airdrop to 6LD7oF4QgDaSRwwGGbgUBAZCC3hLNF1PFn6xxDcLKwgA failed: Internal error"
}

## App Architecture

#### Architecture
- Data - Handles interaction with datasource i.e APIs and shared Preferences
- Domain - Handles buisness logics - recieves event from presentation layer, then processes response from Data layer maps them to DTOs (Data transfer objects) and sends them to presentation layer to update UI;
- Presentation - Handles UI and states
