#[starknet::contract]
mod MyNft {
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use openzeppelin::token::erc721::ERC721;

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Transfer: Transfer,
        Approval: Approval,
        ApprovalForAll: ApprovalForAll
    }

    #[derive(Drop, starknet::Event)]
    struct Transfer {
        from: ContractAddress,
        to: ContractAddress,
        token_id: u256
    }

    #[derive(Drop, starknet::Event)]
    struct Approval {
        owner: ContractAddress,
        approved: ContractAddress,
        token_id: u256
    }

    #[derive(Drop, starknet::Event)]
    struct ApprovalForAll {
        owner: ContractAddress,
        operator: ContractAddress,
        approved: bool
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        recipient: ContractAddress
    ) {
        let name = 'TOCE NFT';
        let symbol = 'TCN';
        let token_id = 0;

        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::InternalImpl::initializer(ref unsafe_state, name, symbol);
        ERC721::InternalImpl::_mint(ref unsafe_state, recipient, token_id);
        // let token_uri = token_uri(ref unsafe_state, token_id);
        // ERC721::InternalImpl::_set_token_uri(ref unsafe_state, token_id, token_uri);
    }

    //
    // Read Method
    //

    #[external(v0)]
    fn supportsInterface(self: @ContractState, interfaceId: felt252) -> bool {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::SRC5CamelImpl::supportsInterface(@unsafe_state, interfaceId)
    }

    #[external(v0)]
    fn name(self: @ContractState) -> felt252 {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721MetadataImpl::name(@unsafe_state)
    }

    #[external(v0)]
    fn symbol(self: @ContractState) -> felt252 {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721MetadataImpl::symbol(@unsafe_state)
    }

    #[external(v0)]
    fn tokenURI(self: @ContractState, token_id: u256) -> felt252 {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721MetadataImpl::token_uri(@unsafe_state, token_id)
    }

    #[external(v0)]
    fn balanceOf(self: @ContractState, account: ContractAddress) -> u256 {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::balanceOf(@unsafe_state, account)
    }

    #[external(v0)]
    fn ownerOf(self: @ContractState, tokenId: u256) -> ContractAddress {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::ownerOf(@unsafe_state, tokenId)
    }

    #[external(v0)]
    fn getApproved(self: @ContractState, tokenId: u256) -> ContractAddress {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::getApproved(@unsafe_state, tokenId)
    }

    #[external(v0)]
    fn isApprovedForAll(
        self: @ContractState, owner: ContractAddress, operator: ContractAddress
    ) -> bool {
        let unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::isApprovedForAll(@unsafe_state, owner, operator)
    }

    //
    // Write Method
    //

    #[external(v0)]
    fn setApprovalForAll(ref self: ContractState, operator: ContractAddress, approved: bool) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::setApprovalForAll(ref unsafe_state, operator, approved)
    }

    #[external(v0)]
    fn transferFrom(
        ref self: ContractState, from: ContractAddress, to: ContractAddress, tokenId: u256
    ) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::transferFrom(ref unsafe_state, from, to, tokenId)
    }

    #[external(v0)]
    fn safeTransferFrom(
        ref self: ContractState,
        from: ContractAddress,
        to: ContractAddress,
        tokenId: u256,
        data: Span<felt252>
    ) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::ERC721CamelOnlyImpl::safeTransferFrom(ref unsafe_state, from, to, tokenId, data)
    }

    #[external(v0)]
    fn approve(ref self: ContractState, to: ContractAddress, tokenId: u256) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::InternalImpl::_approve(ref unsafe_state, to, tokenId)
    }

    #[external(v0)]
    fn mint(ref self: ContractState, tokenId: u256) {
        let caller = get_caller_address();
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::InternalImpl::_mint(ref unsafe_state, caller, tokenId)
    }

    #[external(v0)]
    fn burn(ref self: ContractState, tokenId: u256) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::InternalImpl::_burn(ref unsafe_state, tokenId)
    }

    #[external(v0)]
    fn setTokenURI(ref self: ContractState, tokenId: u256, tokenURI: felt252) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
        ERC721::InternalImpl::_set_token_uri(ref unsafe_state, tokenId, tokenURI)
    }

    #[external(v0)]
    fn setMintPrice(ref self: ContractState, price: felt252) {
        let mut unsafe_state = ERC721::unsafe_new_contract_state();
    }

    // #[external(v0)]
    // fn token_uri(self: ContractState, tokenId: u256) -> Array<felt252> {
    //     let mut uri : Array<felt252> = Default::default();
    //     uri.append('https://ipfs.io/ipfs/bafybeibtdrcauvdytbb6cibhzxhregifylcbjzffihrsbiuggwajlumtga/');
    //     return uri
    // }
}