;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\\/\/\.?video.google.\w{2,3}\/videoplay\?docid=([a-z0-9-_]+)/i'
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008B\'/http:\//video\u00F7googleN\u00EA\u00AA\u00BA/videoplay?docid=a-/i\'\u00B8"
(define-fun Witness1 () String (seq.++ "\x8b" (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "\xf7" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "N" (seq.++ "\xea" (seq.++ "\xaa" (seq.++ "\xba" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "a" (seq.++ "-" (seq.++ "/" (seq.++ "i" (seq.++ "'" (seq.++ "\xb8" "")))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\'/http:\//video\x14googleGZ\u00AAz/videoplay?docid=_l/i\'8>\u00A0"
(define-fun Witness2 () String (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "\x14" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "G" (seq.++ "Z" (seq.++ "\xaa" (seq.++ "z" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "_" (seq.++ "l" (seq.++ "/" (seq.++ "i" (seq.++ "'" (seq.++ "8" (seq.++ ">" (seq.++ "\xa0" ""))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" "")))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (str.to_re (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" ""))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" "")))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ ((_ re.loop 2 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (str.to_re (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" ""))))))))))))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))) (str.to_re (seq.++ "/" (seq.++ "i" (seq.++ "'" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
