use v6.d;
use Cro::HTTP::Client;
use Cro::HTTP::Response;
unit class Bugsnag::Organizations;

has Cro::HTTP::Client $.client;

subset Sort of Str where "created_at" | "name" | "favorite";
subset Direction of Str where "asc" | "desc";

method list(Bool :$admin = False, Int() :$per_page = 10) {
	my Cro::HTTP::Response $res = await $.client.get("/user/organizations", query => { :$admin, :$per_page });
	return await $res.body;
}

method projects(Str $org_id,Str :$query,Sort :$sort = "created_at", Direction :$direction = "desc",
                Int() :$per_page = 30) {
	my Cro::HTTP::Response $res = await $.client.get("/organizations/$org_id/projects", query => {
		:$per_page, q => $query, :$sort, :$direction

	});
	return await $res.body;
}

method get(Str $org_id) {
	my Cro::HTTP::Response $res = await $.client.get("/organizations/$org_id");
	return await $res.body;
}