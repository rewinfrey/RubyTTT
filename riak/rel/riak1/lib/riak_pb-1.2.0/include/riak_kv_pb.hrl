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

-ifndef(RPBGETCLIENTIDRESP_PB_H).
-define(RPBGETCLIENTIDRESP_PB_H, true).
-record(rpbgetclientidresp, {
    client_id = erlang:error({required, client_id})
}).
-endif.

-ifndef(RPBSETCLIENTIDREQ_PB_H).
-define(RPBSETCLIENTIDREQ_PB_H, true).
-record(rpbsetclientidreq, {
    client_id = erlang:error({required, client_id})
}).
-endif.

-ifndef(RPBGETREQ_PB_H).
-define(RPBGETREQ_PB_H, true).
-record(rpbgetreq, {
    bucket = erlang:error({required, bucket}),
    key = erlang:error({required, key}),
    r,
    pr,
    basic_quorum,
    notfound_ok,
    if_modified,
    head,
    deletedvclock
}).
-endif.

-ifndef(RPBGETRESP_PB_H).
-define(RPBGETRESP_PB_H, true).
-record(rpbgetresp, {
    content = [],
    vclock,
    unchanged
}).
-endif.

-ifndef(RPBPUTREQ_PB_H).
-define(RPBPUTREQ_PB_H, true).
-record(rpbputreq, {
    bucket = erlang:error({required, bucket}),
    key,
    vclock,
    content = erlang:error({required, content}),
    w,
    dw,
    return_body,
    pw,
    if_not_modified,
    if_none_match,
    return_head
}).
-endif.

-ifndef(RPBPUTRESP_PB_H).
-define(RPBPUTRESP_PB_H, true).
-record(rpbputresp, {
    content = [],
    vclock,
    key
}).
-endif.

-ifndef(RPBDELREQ_PB_H).
-define(RPBDELREQ_PB_H, true).
-record(rpbdelreq, {
    bucket = erlang:error({required, bucket}),
    key = erlang:error({required, key}),
    rw,
    vclock,
    r,
    w,
    pr,
    pw,
    dw
}).
-endif.

-ifndef(RPBLISTBUCKETSRESP_PB_H).
-define(RPBLISTBUCKETSRESP_PB_H, true).
-record(rpblistbucketsresp, {
    buckets = []
}).
-endif.

-ifndef(RPBLISTKEYSREQ_PB_H).
-define(RPBLISTKEYSREQ_PB_H, true).
-record(rpblistkeysreq, {
    bucket = erlang:error({required, bucket})
}).
-endif.

-ifndef(RPBLISTKEYSRESP_PB_H).
-define(RPBLISTKEYSRESP_PB_H, true).
-record(rpblistkeysresp, {
    keys = [],
    done
}).
-endif.

-ifndef(RPBGETBUCKETREQ_PB_H).
-define(RPBGETBUCKETREQ_PB_H, true).
-record(rpbgetbucketreq, {
    bucket = erlang:error({required, bucket})
}).
-endif.

-ifndef(RPBGETBUCKETRESP_PB_H).
-define(RPBGETBUCKETRESP_PB_H, true).
-record(rpbgetbucketresp, {
    props = erlang:error({required, props})
}).
-endif.

-ifndef(RPBSETBUCKETREQ_PB_H).
-define(RPBSETBUCKETREQ_PB_H, true).
-record(rpbsetbucketreq, {
    bucket = erlang:error({required, bucket}),
    props = erlang:error({required, props})
}).
-endif.

-ifndef(RPBMAPREDREQ_PB_H).
-define(RPBMAPREDREQ_PB_H, true).
-record(rpbmapredreq, {
    request = erlang:error({required, request}),
    content_type = erlang:error({required, content_type})
}).
-endif.

-ifndef(RPBMAPREDRESP_PB_H).
-define(RPBMAPREDRESP_PB_H, true).
-record(rpbmapredresp, {
    phase,
    response,
    done
}).
-endif.

-ifndef(RPBINDEXREQ_PB_H).
-define(RPBINDEXREQ_PB_H, true).
-record(rpbindexreq, {
    bucket = erlang:error({required, bucket}),
    index = erlang:error({required, index}),
    qtype = erlang:error({required, qtype}),
    key,
    range_min,
    range_max
}).
-endif.

-ifndef(RPBINDEXRESP_PB_H).
-define(RPBINDEXRESP_PB_H, true).
-record(rpbindexresp, {
    keys = []
}).
-endif.

-ifndef(RPBCONTENT_PB_H).
-define(RPBCONTENT_PB_H, true).
-record(rpbcontent, {
    value = erlang:error({required, value}),
    content_type,
    charset,
    content_encoding,
    vtag,
    links = [],
    last_mod,
    last_mod_usecs,
    usermeta = [],
    indexes = [],
    deleted
}).
-endif.

-ifndef(RPBLINK_PB_H).
-define(RPBLINK_PB_H, true).
-record(rpblink, {
    bucket,
    key,
    tag
}).
-endif.

-ifndef(RPBBUCKETPROPS_PB_H).
-define(RPBBUCKETPROPS_PB_H, true).
-record(rpbbucketprops, {
    n_val,
    allow_mult
}).
-endif.

