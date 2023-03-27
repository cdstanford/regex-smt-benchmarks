;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\\/\/\.?video.google.\w{2,3}\/videoplay\?docid=([a-z0-9-_]+)/i'
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008B\'/http:\//video\u00F7googleN\u00EA\u00AA\u00BA/videoplay?docid=a-/i\'\u00B8"
(define-fun Witness1 () String (str.++ "\u{8b}" (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "\u{f7}" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "N" (str.++ "\u{ea}" (str.++ "\u{aa}" (str.++ "\u{ba}" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "a" (str.++ "-" (str.++ "/" (str.++ "i" (str.++ "'" (str.++ "\u{b8}" "")))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\'/http:\//video\x14googleGZ\u00AAz/videoplay?docid=_l/i\'8>\u00A0"
(define-fun Witness2 () String (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "\u{14}" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "G" (str.++ "Z" (str.++ "\u{aa}" (str.++ "z" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "_" (str.++ "l" (str.++ "/" (str.++ "i" (str.++ "'" (str.++ "8" (str.++ ">" (str.++ "\u{a0}" ""))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" "")))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (str.to_re (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" ""))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" "")))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ ((_ re.loop 2 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (str.to_re (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" ""))))))))))))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))) (str.to_re (str.++ "/" (str.++ "i" (str.++ "'" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
