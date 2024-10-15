# @TEST-DOC: Test that SSLRequest is recognized and ssl.log exists
#
# @TEST-REQUIRES: ${SCRIPTS}/have-spicy
# @TEST-EXEC: zeek -b -Cr ${TRACES}/postgresql/psql-aws-ssl-require.pcap %INPUT
# @TEST-EXEC: zeek-cut -m ts uid id.orig_h id.orig_p id.resp_h id.resp_p service  < conn.log > conn.cut
# @TEST-EXEC: zeek-cut -m ts uid id.orig_h id.orig_p id.resp_h id.resp_p version cipher curve server_name < ssl.log > ssl.cut
# @TEST-EXEC: zeek-cut -m < postgresql.log > postgresql.cut
#
# @TEST-EXEC: btest-diff conn.cut
# @TEST-EXEC: btest-diff ssl.cut
# @TEST-EXEC: btest-diff postgresql.cut

@load base/protocols/conn
@load base/protocols/postgresql
@load base/protocols/ssl
