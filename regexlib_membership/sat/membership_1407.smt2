;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\s|\n|^)(\w+://[^\s\n]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A0\u00FC://\u00EE\u00D4\u00AD"
(define-fun Witness1 () String (seq.++ "\xa0" (seq.++ "\xfc" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xee" (seq.++ "\xd4" (seq.++ "\xad" "")))))))))
;witness2: "\u0085\u00BA://H\u009Bg\u00D9\u00F1\u00A5"
(define-fun Witness2 () String (seq.++ "\x85" (seq.++ "\xba" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "H" (seq.++ "\x9b" (seq.++ "g" (seq.++ "\xd9" (seq.++ "\xf1" (seq.++ "\xa5" ""))))))))))))

(assert (= regexA (re.++ (re.union (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (str.to_re "")) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
