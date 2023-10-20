from brownie import AdvancedCollectible


def main():
    flatten()


def flatten():
    file = open("./AdvancedCollectible_flattned.sol", "w")
    verification_information = AdvancedCollectible.get_verfication_info()
    flattened_code = (
        verification_information["flattned_source"]
        .replace("\\n", "\n")
        .replace('\\"', '"')
    )
    file.write(flattened_code)
    file.close()