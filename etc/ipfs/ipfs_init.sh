#!/bin/bash

set -e

# ====== BOOT ======
ipfs init --profile=server
jq '.Identity.PrivKey="CAESQIksHEvxTAU+xZ/Ohm05CCRL26lyCty/jUlmbFbkMGS2U138FbS4D3wW+teWEuDNJgJ0BF+guCywSRDT7dYswn8="' ~/.ipfs/config > ~/.ipfs/config.tmp && mv ~/.ipfs/config.tmp ~/.ipfs/config
ipfs config --json Identity.PeerID '"12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair"'
ipfs bootstrap rm --all
ipfs config --json Peering.Peers '[{"ID": "12D3KooWHgSc6JyTMXZR9phywKPkVhyfXX7Gxv58usTQ6ZbCBo6e"}]'
ipfs config --json Import.CidVersion '1'
ipfs config --json Datastore.StorageMax '"20GB"'
ipfs config --json Swarm.DisableBandwidthMetrics 'true'

# ====== NAT ======
ipfs init
if [ $PRESET_HOST ]
    jq '.Identity.PrivKey="CAESQOQnlVC6YOPyyPnm9SorHST73Bf4w/PgPUY87ErEkXdWdNXdrBzXvrRFiq94Cqjaj5BgW/kyo5OR0Z+e+KX7gb8="' $USERPROFILE/.ipfs/config > $USERPROFILE/.ipfs/config.tmp && mv $USERPROFILE/.ipfs/config.tmp $USERPROFILE/.ipfs/config
    ipfs config --json Identity.PeerID '"12D3KooWHgSc6JyTMXZR9phywKPkVhyfXX7Gxv58usTQ6ZbCBo6e"'
fi
ipfs bootstrap rm --all
ipfs bootstrap add /ip4/139.224.196.187/tcp/4001/p2p/12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair
ipfs config --json Peering.Peers '[{"ID": "12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair", "Addrs": ["/ip4/139.224.196.187/tcp/4001"]}]'
ipfs config --json Swarm.RelayClient.StaticRelays '["/ip4/139.224.196.187/tcp/4001/p2p/12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair"]'
ipfs config --json Import.CidVersion '1'
ipfs config --json Datastore.StorageMax '"20GB"'
ipfs swarm connect /ip4/139.224.196.187/tcp/4001/p2p/12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair/p2p-circuit/p2p/12D3KooWHgSc6JyTMXZR9phywKPkVhyfXX7Gxv58usTQ6ZbCBo6e

# ====== FILE ======
ipfs files cp /ipfs/bafybeiguwrde5qhwd3luc46zn7dwe7lqi5jjq7fpnzkb6zvnzaw3a2o2ma /IpfsDoc
ipfs files cp /ipfs/bafybeiaysi4s6lnjev27ln5icwm6tueaw2vdykrtjkwiphwekaywqhcjze /WikipediaEn
ipfs files cp /ipfs/bafybeif2i23vccrzd4urdj33kvqek5um6egmv25dgseeufdube37d6pgje /WikipediaZh
ipfs files cp /ipfs/QmcTJvrVj9BFckmghjCGKWDzsj9BRCuKFcSsWsGM5Jq3GE /TianYaShenTie
