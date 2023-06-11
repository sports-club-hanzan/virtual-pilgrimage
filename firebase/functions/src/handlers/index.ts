import * as updateUserHealth from "./update-health";
import * as deleteUser from "./delete-user";
import * as updateRanking from "./ranking";

export const handlers = { ...updateUserHealth, ...deleteUser, ...updateRanking };
