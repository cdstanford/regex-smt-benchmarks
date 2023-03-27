;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\)?)|(\d{3}))([\s-./]?)(\d{3})([\s-./]?)(\d{4})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "880\u008594929097#\xBE\x2\u00E2T\x7"
(define-fun Witness1 () String (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "\u{85}" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "7" (str.++ "#" (str.++ "\u{0b}" (str.++ "E" (str.++ "\u{02}" (str.++ "\u{e2}" (str.++ "T" (str.++ "\u{07}" ""))))))))))))))))))))
;witness2: "\u00EE9817390/0156\x9\u00D5bt\u00F2q\u00BB\u00B2\xB"
(define-fun Witness2 () String (str.++ "\u{ee}" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "7" (str.++ "3" (str.++ "9" (str.++ "0" (str.++ "/" (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "6" (str.++ "\u{09}" (str.++ "\u{d5}" (str.++ "b" (str.++ "t" (str.++ "\u{f2}" (str.++ "q" (str.++ "\u{bb}" (str.++ "\u{b2}" (str.++ "\u{0b}" "")))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")")))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
