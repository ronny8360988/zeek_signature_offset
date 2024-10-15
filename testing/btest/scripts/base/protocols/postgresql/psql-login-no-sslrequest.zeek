# @TEST-DOC: The client does not start with SSLRequest. This pcap has two connections, attempting without password.
#
# @TEST-REQUIRES: ${SCRIPTS}/have-spicy
# @TEST-EXEC: zeek -b -Cr ${TRACES}/postgresql/psql-login-no-sslrequest.pcap %INPUT >output
# @TEST-EXEC: zeek-cut -m ts uid id.orig_h id.orig_p id.resp_h id.resp_p service  < conn.log > conn.cut
# @TEST-EXEC: zeek-cut -m < postgresql.log > postgresql.cut
#
# @TEST-EXEC: btest-diff conn.cut
# @TEST-EXEC: btest-diff postgresql.cut

@load base/protocols/conn
@load base/protocols/postgresql
