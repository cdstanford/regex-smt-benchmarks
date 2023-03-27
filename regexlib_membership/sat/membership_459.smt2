;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(NAME)(\s?)<?(\w*)(\s*)([0-9]*)>?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "NAME49702999"
(define-fun Witness1 () String (str.++ "N" (str.++ "A" (str.++ "M" (str.++ "E" (str.++ "4" (str.++ "9" (str.++ "7" (str.++ "0" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "9" "")))))))))))))
;witness2: "NAME89>"
(define-fun Witness2 () String (str.++ "N" (str.++ "A" (str.++ "M" (str.++ "E" (str.++ "8" (str.++ "9" (str.++ ">" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "N" (str.++ "A" (str.++ "M" (str.++ "E" "")))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "<" "<"))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range ">" ">")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
