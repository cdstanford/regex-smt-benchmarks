;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http://|)(www\.)?([^\.]+)\.(\w{2}|(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://www.\u00EDn.coop"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "\xed" (seq.++ "n" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "o" (seq.++ "p" "")))))))))))))))))))
;witness2: "\x9\u00BEe.info"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "\xbe" (seq.++ "e" (seq.++ "." (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))) (str.to_re ""))(re.++ (re.opt (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))))(re.++ (re.+ (re.union (re.range "\x00" "-") (re.range "/" "\xff")))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "i" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "r" (seq.++ "p" (seq.++ "a" "")))))(re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "z" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "o" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "p" (seq.++ "r" (seq.++ "o" "")))) (str.to_re (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" "")))))))))))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
