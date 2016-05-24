use result::Result;

use hoedown::renderer::Render;
use hoedown::Buffer;
use hoedown::Markdown;

pub struct Link {
    pub title: String,
    pub link: String,
}

struct LinkExtractor {
    links: Vec<Link>,
}

impl LinkExtractor {

    pub fn new() -> LinkExtractor {
        LinkExtractor { links: vec![] }
    }

    pub fn links(self) -> Vec<Link> {
        self.links
    }

}

impl Render for LinkExtractor {

    fn link(&mut self,
            _: &mut Buffer,
            _: Option<&Buffer>,
            link: Option<&Buffer>,
            title: Option<&Buffer>)
        -> bool
    {
        let link  = link.and_then(|l| l.to_str().ok()).map(String::from);
        let title = title.and_then(|l| l.to_str().ok()).map(String::from);

        match (link, title) {
            (Some(link), Some(title)) => {
                self.links.push(Link { link: link, title: title });
                true
            },

            (a, b) => {
                debug!("Cannot extract link from ({:?}, {:?})", a, b);
                false
            },
        }

    }

}

pub fn extract_links(buf: &str) -> Vec<Link> {
    let mut le = LinkExtractor::new();
    le.render(&Markdown::new(buf));
    le.links()
}

