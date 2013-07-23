package com.engagemobile.vsfootball.net;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

@Path("")
public interface UserService_New {

	@POST
	@Produces("application/json")
	Response userLogin(@QueryParam("username") String username, @QueryParam("password") String password);

}
