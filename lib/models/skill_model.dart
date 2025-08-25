class SkillCategory {
  final String category;
  final List<String> items;

  const SkillCategory(this.category, this.items);
}

List<SkillCategory> getSkills() {
  return const [
    SkillCategory('Languages', ['TypeScript', 'Lua', 'Python', 'JavaScript']),
    SkillCategory('Databases', ['SQLite', 'PostgreSQL', 'Mongo']),
    SkillCategory('Tools', ['VSCode', 'Neovim', 'Linux', 'Git', 'Font Awesome']),
    SkillCategory('Other', ['HTML', 'CSS', 'EJS', 'SCSS', 'REST', 'Jinja']),
    SkillCategory('Frameworks', ['React', 'Vue', 'Djsnake', 'Discord.Js', 'Flask', 'Express.Js']),
  ];
}