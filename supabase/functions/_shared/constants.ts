export const constants = {
  canBeSeenBy: {
    onlySchoolMembers: "ONLY_SCHOOL_MEMBERS",
    onlySubcategoryPeople: "ONLY_SUBCATEGORY_PEOPLE",
    everyone: "EVERYONE",
  },
  partnerQuery: "id, name, firstName, lastName, profileImage",
  coupleQuery:
    "id, initiatedById, partner1:users!couples_partner1_id_fkey(id, name, firstName, lastName, profileImage), partner2:users!couples_partner2_id_fkey(id, name, firstName, lastName, profileImage), anniversary, isActive, isRejected, isAccepted",
  userQuery: "id, name, firstName, lastName, profileImage",
  acquaintedQuestionQuery:
    "acquainted_questions(*, text_content(*, translations(*)))",
  dailyQuestionQuery:
    "question:text_content!daily_questions_question_fkey(*, translations(*)), option1:text_content!daily_questions_option1_fkey(*, translations(*)), option2:text_content!daily_questions_option2_fkey(*, translations(*)), option3:text_content!daily_questions_option3_fkey(*, translations(*)), option4:text_content!daily_questions_option4_fkey(*, translations(*))",
  dailyQuotesQuery: "text_content(*, translations(*))",
};
