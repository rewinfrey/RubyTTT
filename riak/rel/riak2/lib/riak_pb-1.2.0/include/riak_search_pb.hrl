-ifndef(RPBERRORRESP_PB_H).
-define(RPBERRORRESP_PB_H, true).
-record(rpberrorresp, {
    errmsg = erlang:error({required, errmsg}),
    errcode = erlang:error({required, errcode})
}).
-endif.

-ifndef(RPBGETSERVERINFORESP_PB_H).
-define(RPBGETSERVERINFORESP_PB_H, true).
-record(rpbgetserverinforesp, {
    node,
    server_version
}).
-endif.

-ifndef(RPBPAIR_PB_H).
-define(RPBPAIR_PB_H, true).
-record(rpbpair, {
    key = erlang:error({required, key}),
    value
}).
-endif.

-ifndef(RPBSEARCHDOC_PB_H).
-define(RPBSEARCHDOC_PB_H, true).
-record(rpbsearchdoc, {
    fields = []
}).
-endif.

-ifndef(RPBSEARCHQUERYREQ_PB_H).
-define(RPBSEARCHQUERYREQ_PB_H, true).
-record(rpbsearchqueryreq, {
    q = erlang:error({required, q}),
    index = erlang:error({required, index}),
    rows,
    start,
    sort,
    filter,
    df,
    op,
    fl = [],
    presort
}).
-endif.

-ifndef(RPBSEARCHQUERYRESP_PB_H).
-define(RPBSEARCHQUERYRESP_PB_H, true).
-record(rpbsearchqueryresp, {
    docs = [],
    max_score,
    num_found
}).
-endif.

