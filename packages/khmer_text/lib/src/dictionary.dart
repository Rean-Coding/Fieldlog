/// A starter Khmer wordlist for [KhmerSegmenter].
///
/// **This is a starter, not a dictionary.** It holds a few hundred of the most
/// common words — enough to demonstrate segmentation, to break UI strings, and
/// to write tests against. It is not enough for arbitrary prose.
///
/// For production, load a real wordlist at startup and pass it to
/// `KhmerSegmenter(words: …)`. Good sources are the Chuon Nath dictionary word
/// data and the Khmer dictionary that ships inside ICU; both are far larger
/// than anything worth compiling into a package.
library;

const starterKhmerWords = <String>{
  // pronouns and function words
  'ខ្ញុំ', 'អ្នក', 'គាត់', 'យើង', 'គេ', 'វា',
  'នេះ', 'នោះ', 'និង', 'ដែល', 'បាន', 'ជា', 'គឺ',
  'នៅ', 'ពី', 'លើ', 'ក្នុង', 'ក្រៅ', 'ជាមួយ', 'សម្រាប់',
  'ដើម្បី', 'ព្រោះ', 'ប៉ុន្តែ', 'ក៏', 'មិន', 'ទេ', 'អត់',
  'ហើយ', 'រួច', 'នឹង', 'កំពុង', 'ត្រូវ', 'អាច', 'ចង់', 'មាន',
  'ទៅ', 'មក', 'ធ្វើ', 'ការ', 'របស់', 'ទាំងអស់', 'គ្រប់', 'ខ្លះ',

  // numbers and time
  'មួយ', 'ពីរ', 'បី', 'បួន', 'ប្រាំ', 'ដប់', 'រយ', 'ពាន់',
  'ថ្ងៃ', 'ខែ', 'ឆ្នាំ', 'ម៉ោង', 'នាទី', 'វិនាទី', 'ពេល',
  'ឥឡូវ', 'ថ្ងៃនេះ', 'ម្សិលមិញ', 'ស្អែក', 'មុន', 'ក្រោយ',

  // qualities
  'ថ្មី', 'ចាស់', 'ធំ', 'តូច', 'ល្អ', 'ច្រើន', 'តិច', 'លឿន', 'យឺត',

  // place and language
  'ប្រទេស', 'កម្ពុជា', 'ភ្នំពេញ', 'ភាសា', 'ខ្មែរ', 'អង់គ្លេស',

  // the vocabulary an app actually needs
  'កម្មវិធី', 'ទូរស័ព្ទ', 'កុំព្យូទ័រ', 'អ៊ីនធឺណិត', 'បណ្ដាញ',
  'ព័ត៌មាន', 'ទិន្នន័យ', 'ឯកសារ', 'រូបភាព', 'សៀវភៅ', 'ទំព័រ',
  'ឈ្មោះ', 'លេខ', 'អាសយដ្ឋាន', 'បញ្ជី', 'កំណត់ត្រា', 'ចំណាំ',
  'អ្នកប្រើ', 'ពាក្យសម្ងាត់', 'គណនី', 'ការកំណត់', 'ជំនួយ',
  'រក្សាទុក', 'លុប', 'កែ', 'បន្ថែម', 'ស្វែងរក', 'តម្រៀប',
  'ចូល', 'ចេញ', 'បិទ', 'បើក', 'ផ្ញើ', 'ទទួល', 'ទាញយក',
  'កំហុស', 'ជោគជ័យ', 'បរាជ័យ', 'ព្រមាន', 'សារ', 'ស្ថានភាព',
  'កំពុងផ្ទុក', 'ទទេ', 'រង់ចាំ', 'ព្យាយាម', 'ម្ដងទៀត',

  // courtesy
  'សូម', 'អរគុណ', 'សួស្ដី', 'បាទ', 'ចាស', 'សុំទោស',
};
