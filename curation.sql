-- curation.sql: editorial decisions for my student wellbeing site
--
-- Persona (see persona.md): a first-year University of Hertfordshire
-- student on a tight budget who wants cheap or free ways to stay active
-- and look after their wellbeing. They do not need WordPress boilerplate,
-- legal pages, empty navigation pages or demo content, so those are
-- hidden below.

-- WordPress adds the same default "About" page to every new site.
UPDATE posts SET isPublic = 0 WHERE post_name = 'about';

-- Default and legal pages found by searching the data in the sandbox.
-- IDs are only unique within a site, so each rule uses site_id and id.
UPDATE posts SET isPublic = 0
WHERE (site_id = 'site1' AND id = 690)       -- About Us
   OR (site_id = 'site2' AND id IN (1, 3, 146)) -- What we are about, Hello World!, Privacy and Cookies
   OR (site_id = 'site3' AND id IN (3, 15))     -- Hello World!, About us
   OR (site_id = 'site4' AND id = 531)          -- Privacy Policy
   OR (site_id = 'site5' AND id = 9);           -- About

-- These four site2 posts are WordPress demo content, not about fitness
-- or Hertfordshire, so they would confuse a student looking for activities.
UPDATE posts SET isPublic = 0
WHERE site_id = 'site2'
  AND post_name IN ('the-art-of-connection', 'beyond-the-obstacle',
                    'growth-unlocked', 'collaboration-magic');

-- These pages only held WordPress "page list" blocks, which render as
-- blank cards outside WordPress, so they are hidden rather than shown empty.
UPDATE posts SET isPublic = 0
WHERE post_type = 'page'
  AND post_name IN ('social-groups', 'by-region', 'walking', 'welwyn-and-hatfield',
                    'st-albans', 'tring', 'parks', 'gyms', 'outdoors', 'free');

-- The homepage slideshow post had no title, so a card would show a blank
-- heading. Left switched off until I decide whether to show it at all.
-- UPDATE posts SET title = 'Home page highlights' WHERE site_id = 'site1' AND id = 88;

-- The starter hid posts with "food" in the title. A student on a budget
-- may want cheap and healthy eating tips, so this rule is switched off.
-- UPDATE posts SET isPublic = 0 WHERE LOWER(title) LIKE '%food%';