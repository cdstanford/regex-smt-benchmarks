;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+(.)?[\s]*)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z\u00FD\u0085\xC"
(define-fun Witness1 () String (str.++ "Z" (str.++ "\u{fd}" (str.++ "\u{85}" (str.++ "\u{0c}" "")))))
;witness2: "GZGkaZ\u00AF"
(define-fun Witness2 () String (str.++ "G" (str.++ "Z" (str.++ "G" (str.++ "k" (str.++ "a" (str.++ "Z" (str.++ "\u{af}" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
