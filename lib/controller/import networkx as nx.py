import networkx as nx
from networkx import Graph


def construct_graph_from_csc(file_path):
    """
    Construct a graph from a CSC (Contiki Simulation Configuration) file.

    Args:
    - file_path (str): Path to the CSC file.

    Returns:
    - G (nx.Graph): Graph constructed from the CSC data.
    """
    G: Graph = nx.Graph()
    with open(file_path, 'r') as f:
        lines = f.readlines()
        for line in lines:
            # Process each line of the CSC file and add nodes and edges to the graph
            if line.startswith('node'):
                _, node_id, _ = line.strip().split(' ')
                G.add_node(node_id)
            elif line.startswith('edge'):
                _, source, target, _ = line.strip().split(' ')
                G.add_edge(source, target)
    return G


def get_connected_components(graph):
    """
    Get the connected components of a graph.

    Args:
    - graph (nx.Graph): Input graph.

    Returns:
    - components (list): List of connected components.
    """
    return list(nx.connected_components(graph))


# Path to the CSC file containing simulation data
csc_file_path = "simulation.csc"

# Construct the graph from the CSC file
simulation_graph = construct_graph_from_csc(csc_file_path)

# Get the connected components of the graph
components = get_connected_components(simulation_graph)

# Print and display the connected components
for i, component in enumerate(components, start=1):
    print("Connected component " + str(i) + ": " + str(component))