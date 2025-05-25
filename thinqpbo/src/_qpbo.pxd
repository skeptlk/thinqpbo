# _qpbo.pxd
# distutils: language = c++

from libcpp cimport bool

ctypedef int NodeId;
ctypedef long long EdgeId;

cdef extern from "core/QPBO.h":
    cdef cppclass QPBO[REAL]:
        struct ProbeOptions:
            ProbeOptions()
            int directed_constraints
            int weak_persistencies
            REAL C
            int* order_array
            unsigned int order_seed
            int dilation
            bool (*callback_fn)(int unlabeled_num)
        
        QPBO(int node_num_max, EdgeId edge_num_max) except +
        bool Save(char* filename)
        bool Load(char* filename)
        void Reset()
        EdgeId GetMaxEdgeNum()
        void SetMaxEdgeNum(EdgeId num)
        NodeId AddNode(int num)
        void AddUnaryTerm(NodeId i, REAL E0, REAL E1)
        EdgeId AddPairwiseTerm(NodeId i, NodeId j, REAL E00, REAL E01, REAL E10, REAL E11)
        void AddPairwiseTerm(EdgeId e, NodeId i, NodeId j, REAL E00, REAL E01, REAL E10, REAL E11)
        void MergeParallelEdges()
        int GetLabel(NodeId i)
        void SetLabel(NodeId i, char label)
        int GetNodeNum()
        void GetTwiceUnaryTerm(NodeId i, REAL& E0, REAL& E1)
        void GetTwicePairwiseTerm(EdgeId e, NodeId& i, NodeId& j, REAL& E00, REAL& E01, REAL& E10, REAL& E11);
        REAL ComputeTwiceEnergy(int option)
        REAL ComputeTwiceEnergy(int* labeling)
        REAL ComputeTwiceLowerBound()
        void Solve()
        void ComputeWeakPersistencies()
        void Stitch()
        int GetRegion(NodeId i)
        bool Improve(int N, int* order_array, int* fixed_nodes)
        bool Improve()
        void Probe(int* mapping, ProbeOptions& option) except +