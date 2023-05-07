part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final ProjectViewModel? projectViewModel;

  const ProjectDetailState._({
    required this.status,
    this.projectViewModel,
  });

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    ProjectViewModel? projectViewModel,
  }) {
    return ProjectDetailState._(
      status: status ?? this.status,
      projectViewModel: projectViewModel ?? this.projectViewModel,
    );
  }

  @override
  List<Object?> get props => [status, projectViewModel];
}
