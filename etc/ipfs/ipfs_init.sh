#!/bin/bash

set -e

# init
ipfs init --profile=server

# key
jq '.Identity.PrivKey="CAESQIksHEvxTAU+xZ/Ohm05CCRL26lyCty/jUlmbFbkMGS2U138FbS4D3wW+teWEuDNJgJ0BF+guCywSRDT7dYswn8="' ~/.ipfs/config > ~/.ipfs/config.tmp && mv ~/.ipfs/config.tmp ~/.ipfs/config
ipfs config --json Identity.PeerID '"12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair"'

# peers
ipfs config --json Peering.Peers '[{"ID": "12D3KooWFRo8PmgF6RiSsZRyTsNS7fghhuVyHHoNktJtndA3uair", "Addrs": ["/ip4/139.224.196.187/tcp/4001"]}]'
ipfs config --json Peering.Peers '[{"ID": "12D3KooWHgSc6JyTMXZR9phywKPkVhyfXX7Gxv58usTQ6ZbCBo6e"}]'

# misc
ipfs config --json Import.CidVersion '1'
ipfs config --json Datastore.StorageMax '"20GB"'
ipfs config --json Swarm.DisableBandwidthMetrics 'true'
