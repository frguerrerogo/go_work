abstract class Adapter<Entity, Model> {
  // Convierte una entidad a un modelo
  Model toModel(Entity entity);

  // Convierte un modelo a una entidad
  Entity toEntity(Model model);
}
