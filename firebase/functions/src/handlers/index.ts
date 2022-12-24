import * as deleteUser from "./delete-user";
import * as updateRanking from "./ranking";

export const handlers = { ...deleteUser, ...updateRanking };
