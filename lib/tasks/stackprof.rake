namespace :stackprof do
  desc 'Benchmark for ActiveRecord with stackprof'
  task active_record: :environment do
    StackProf.run(mode: :cpu, out: 'tmp/stackprof/active_record/cpu-full-find_by_sql.dump') do
      ContentType.find_by_sql(["SELECT * FROM `content_types` LEFT OUTER JOIN `contents` ON `contents`.`content_type_id` = `content_types`.`id` LEFT OUTER JOIN `comments` ON `comments`.`content_id` = `contents`.`id` LEFT OUTER JOIN `authors` ON `authors`.`id` = `comments`.`author_id`"])
    end

    StackProf.run(mode: :cpu, out: 'tmp/stackprof/active_record/cpu-full-select_all.dump') do
      ActiveRecord::Base.connection.select_all("SELECT `content_types`.`id` AS t0_r0, `content_types`.`name` AS t0_r1, `content_types`.`created_at` AS t0_r2, `content_types`.`updated_at` AS t0_r3, `contents`.`id` AS t1_r0, `contents`.`title` AS t1_r1, `contents`.`body` AS t1_r2, `contents`.`content_type_id` AS t1_r3, `contents`.`author_id` AS t1_r4, `contents`.`created_at` AS t1_r5, `contents`.`updated_at` AS t1_r6, `comments`.`id` AS t2_r0, `comments`.`body` AS t2_r1, `comments`.`content_id` AS t2_r2, `comments`.`author_id` AS t2_r3, `comments`.`created_at` AS t2_r4, `comments`.`updated_at` AS t2_r5, `authors`.`id` AS t3_r0, `authors`.`name` AS t3_r1, `authors`.`created_at` AS t3_r2, `authors`.`updated_at` AS t3_r3 FROM `content_types` LEFT OUTER JOIN `contents` ON `contents`.`content_type_id` = `content_types`.`id` LEFT OUTER JOIN `comments` ON `comments`.`content_id` = `contents`.`id` LEFT OUTER JOIN `authors` ON `authors`.`id` = `comments`.`author_id`").to_a
    end

    # StackProf.run(mode: :cpu, out: 'tmp/stackprof/active_record/cpu-full-preload.dump') do
    #   ContentType.preload(contents: {comments: :author}).to_a
    # end

    # StackProf.run(mode: :cpu, out: 'tmp/stackprof/active_record/cpu-full.dump') do
    #   ContentType.eager_load(contents: {comments: :author}).to_a
    # end
    #
    # StackProf.run(mode: :cpu, out: 'tmp/stackprof/active_record/cpu-conditional.dump') do
    #   ContentType.eager_load(contents: {conditional_comments: :author}).where('contents.id < ?', 1000).to_a
    # end
  end
end