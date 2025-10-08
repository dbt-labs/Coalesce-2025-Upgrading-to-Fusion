# ⚡ dbt Fusion Upgrade Training

Welcome to the **Coalesce 2025 dbt Fusion Upgrade Training**! This training repository provides hands-on experience upgrading from **dbt Core to dbt Fusion**.

## 🎯 Training Objectives

Practice upgrading a real dbt Core project to dbt Fusion while resolving both **hard blockers** (compilation/runtime issues) and **soft blockers** (best practices and optimization opportunities).

## 🚀 Getting Started

### 1. Create Your Training Branch

Create a new branch using this naming convention:
```bash
git checkout -b firstname_lastname_fusion_migration
```

### 2. Set Up Your Environment

1. **Update credentials**: Modify `profiles.yml` and/or `dbt_project.yml` to use your Snowflake ZNA credentials
2. **Seed the data**: Run `dbt seed` in dbt Core first to create the underlying data sources
3. **Begin migration**: Use the migration helper in VS Code:
   ```bash
   dbtf init --fusion-upgrade
   ```

### 3. Work Through Blockers

- **🔴 Hard blockers**: Must be fixed before Fusion will compile/run
  - Deprecated configurations
  - Broken macros
  - Incompatible syntax
  
- **🟡 Soft blockers**: Warnings and best practice improvements
  - Model naming conventions
  - Semantic configurations
  - Performance optimizations

### 4. Submit Your Work

1. Push your branch to GitHub
2. Open a pull request for review
3. Share your migration approach with the group

## 📋 Training Resources

### Repository Structure

This training repository includes:

- **Sample dbt Core project** with realistic complexity
- **Mixed blockers** representing common migration challenges
- **Documentation examples** showing before/after patterns
- **Test scenarios** to validate your migration

### Key Areas to Focus On

!!! tip "Migration Checklist"
    - [ ] Profile and project configuration updates
    - [ ] Deprecated syntax resolution
    - [ ] Macro compatibility
    - [ ] Model materialization strategies
    - [ ] Testing framework updates
    - [ ] Documentation enhancements

## 🔗 Helpful Links

- [dbt Fusion Documentation](https://docs.getdbt.com/docs/dbt-cloud-environments)
- [Migration Guide](https://docs.getdbt.com/guides/migration/overview)
- [Training Repository](https://github.com/dbt-labs/Coalesce-2025-Upgrading-to-Fusion)

## 💡 Tips for Success

!!! note "Best Practices"
    - Start with hard blockers first
    - Test incrementally after each fix
    - Document your migration decisions
    - Ask questions during the training session

## 🆘 Need Help?

During the training session:
- Raise your hand for instructor assistance
- Use Slack for quick questions
- Review other participants' approaches via their pull requests

---

**Ready to begin?** Clone the repository, create your branch, and start your dbt Fusion migration journey!