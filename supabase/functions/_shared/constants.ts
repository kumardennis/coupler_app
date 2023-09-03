export const constants = {
  canBeSeenBy: {
    onlySchoolMembers: "ONLY_SCHOOL_MEMBERS",
    onlySubcategoryPeople: "ONLY_SUBCATEGORY_PEOPLE",
    everyone: "EVERYONE",
  },
  coupleQuery:
    "id, partner1:users!couples_partner1_id_fkey(id, name, firstName, lastName, profileImage), partner2:users!couples_partner2_id_fkey(id, name, firstName, lastName, profileImage), anniversary, isActive",
  userQuery: "id, name, firstName, lastName, profileImage",
  acquaintedQuestionQuery:
    "acquainted_questions(*, text_content(*, translations(*)))",
};
