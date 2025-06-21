# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# frozen_string_literal: true

# Only run seeds in development and production, not in test environment
# Test environment should use fixtures instead
return if Rails.env.test?

# Clear existing data
puts "🧹 Clearing existing data..."
Post.destroy_all
User.destroy_all

puts "👥 Creating users..."

# Create users with realistic data
users_data = [
  {
    name: "Alice Johnson",
    email: "alice.johnson@example.com",
    age: 28,
    active: true,
    bio: "Software engineer passionate about Ruby and Rails. Love building scalable web applications."
  },
  {
    name: "Bob Smith",
    email: "bob.smith@example.com",
    age: 35,
    active: true,
    bio: "Full-stack developer with 10 years of experience. Tech lead at a startup."
  },
  {
    name: "Carol Davis",
    email: "carol.davis@example.com",
    age: 42,
    active: true,
    bio: "Senior developer and mentor. Enjoys teaching and contributing to open source."
  },
  {
    name: "David Wilson",
    email: "david.wilson@example.com",
    age: 31,
    active: false,
    bio: "Former developer, now pursuing other interests. Account inactive."
  },
  {
    name: "Emma Brown",
    email: "emma.brown@example.com",
    age: 26,
    active: true,
    bio: "Junior developer eager to learn. Specializing in frontend technologies."
  },
  {
    name: "Frank Miller",
    email: "frank.miller@example.com",
    age: 45,
    active: true,
    bio: "DevOps engineer with expertise in cloud infrastructure and automation."
  },
  {
    name: "Grace Lee",
    email: "grace.lee@example.com",
    age: 29,
    active: true,
    bio: "Product manager turned developer. Bridges the gap between business and tech."
  },
  {
    name: "Henry Taylor",
    email: "henry.taylor@example.com",
    age: 38,
    active: false,
    bio: "Database specialist. Currently on sabbatical."
  }
]

created_users = users_data.map do |user_attrs|
  user = User.create!(user_attrs)
  status = user.active? ? "🟢" : "🔴"
  puts "  #{status} Created user: #{user.name} (#{user.email}) - Age: #{user.age}"
  user
end

puts "📝 Creating posts..."

# Create posts with varied content
posts_data = [
  {
    title: "Getting Started with Ruby on Rails",
    content: "Rails is a powerful web framework that makes development enjoyable and productive. In this post, we'll explore the basics and get you started on your Rails journey.",
    status: "published",
    view_count: 1250,
    rating: 4.5,
    category: "tutorial",
    featured: true,
    published_at: 2.weeks.ago
  },
  {
    title: "Database Optimization Techniques",
    content: "Learn how to optimize your database queries for better performance. We'll cover indexing, query optimization, and common pitfalls to avoid.",
    status: "published",
    view_count: 890,
    rating: 4.2,
    category: "database",
    featured: false,
    published_at: 1.week.ago
  },
  {
    title: "Building RESTful APIs with Rails",
    content: "REST APIs are the backbone of modern web applications. This comprehensive guide shows you how to build robust APIs using Rails.",
    status: "published",
    view_count: 2100,
    rating: 4.8,
    category: "api",
    featured: true,
    published_at: 3.days.ago
  },
  {
    title: "Introduction to Test-Driven Development",
    content: "TDD is a development methodology that can improve code quality and reduce bugs. Let's explore how to implement TDD in your Rails projects.",
    status: "draft",
    view_count: 0,
    rating: nil,
    category: "testing",
    featured: false,
    published_at: nil
  },
  {
    title: "Frontend Integration with Rails",
    content: "Modern web applications often require sophisticated frontend frameworks. Learn how to integrate React, Vue, or other frameworks with Rails.",
    status: "published",
    view_count: 756,
    rating: 4.1,
    category: "frontend",
    featured: false,
    published_at: 5.days.ago
  },
  {
    title: "Deployment Strategies for Rails Apps",
    content: "From development to production: a comprehensive guide to deploying Rails applications using various platforms and strategies.",
    status: "published",
    view_count: 1450,
    rating: 4.6,
    category: "devops",
    featured: true,
    published_at: 1.day.ago
  },
  {
    title: "Working with Background Jobs",
    content: "Learn how to handle time-consuming tasks asynchronously using background job processors like Sidekiq and Resque.",
    status: "review",
    view_count: 12,
    rating: 3.8,
    category: "performance",
    featured: false,
    published_at: nil
  },
  {
    title: "Security Best Practices in Rails",
    content: "Protect your Rails applications from common security vulnerabilities. This guide covers authentication, authorization, and secure coding practices.",
    status: "published",
    view_count: 1850,
    rating: 4.9,
    category: "security",
    featured: true,
    published_at: 4.days.ago
  },
  {
    title: "Scaling Rails Applications",
    content: "As your application grows, you'll face scaling challenges. Learn about caching, database optimization, and architecture patterns for scale.",
    status: "draft",
    view_count: 0,
    rating: nil,
    category: "performance",
    featured: false,
    published_at: nil
  },
  {
    title: "Rails 7: What's New and Exciting",
    content: "Rails 7 brings many improvements and new features. Let's explore the most significant changes and how they impact your development workflow.",
    status: "published",
    view_count: 980,
    rating: 4.3,
    category: "news",
    featured: false,
    published_at: 6.days.ago
  },
  {
    title: "Debugging Rails Applications",
    content: "Effective debugging techniques can save hours of development time. Learn about tools and strategies for finding and fixing bugs quickly.",
    status: "published",
    view_count: 654,
    rating: 4.0,
    category: "tutorial",
    featured: false,
    published_at: 2.days.ago
  },
  {
    title: "Database Migrations Best Practices",
    content: "Database migrations are powerful but can be dangerous in production. Learn how to write safe, reversible migrations that won't break your app.",
    status: "review",
    view_count: 45,
    rating: 4.4,
    category: "database",
    featured: false,
    published_at: nil
  }
]

active_users = created_users.select(&:active?)

posts_data.each_with_index do |post_attrs, index|
  # Assign posts to active users in a round-robin fashion
  user = active_users[index % active_users.length]
  
  post = Post.create!(
    user_id: user.id.to_s,  # Converting to string as per your schema
    title: post_attrs[:title],
    content: post_attrs[:content],
    status: post_attrs[:status],
    view_count: post_attrs[:view_count],
    rating: post_attrs[:rating],
    published_at: post_attrs[:published_at],
    category: post_attrs[:category],
    featured: post_attrs[:featured]
  )
  
  status_emoji = case post.status
                 when "published" then "✅"
                 when "draft" then "📝"
                 when "review" then "👀"
                 else "❓"
                 end
  
  featured_text = post.featured? ? " ⭐" : ""
  rating_text = post.rating ? " (#{post.rating}⭐)" : ""
  
  puts "  #{status_emoji} Created post: '#{post.title}' by #{user.name}#{featured_text}#{rating_text}"
  puts "    Category: #{post.category} | Views: #{post.view_count} | Status: #{post.status}"
end

puts "🎉 Seeding completed!"
puts "📊 Summary:"
puts "  - #{User.count} users created (#{User.where(active: true).count} active)"
puts "  - #{Post.count} posts created"
puts "  - #{Post.where(status: 'published').count} published posts"
puts "  - #{Post.where(status: 'draft').count} draft posts"
puts "  - #{Post.where(status: 'review').count} posts in review"
puts "  - #{Post.where(featured: true).count} featured posts"
puts "  - Average rating: #{Post.where.not(rating: nil).average(:rating).to_f.round(1)}"
