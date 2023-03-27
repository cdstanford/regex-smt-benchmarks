;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i)(pharmacy)|((p(.{1,3})?h(.{1,3})?a(.{1,3})?r(.{1,3)?m(.{1,3})?a(.{1,3})?c(.{1,3})?y))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3PH\x14A\u00DC\u0090\u00D7rMACyy\x1F"
(define-fun Witness1 () String (str.++ "3" (str.++ "P" (str.++ "H" (str.++ "\u{14}" (str.++ "A" (str.++ "\u{dc}" (str.++ "\u{90}" (str.++ "\u{d7}" (str.++ "r" (str.++ "M" (str.++ "A" (str.++ "C" (str.++ "y" (str.++ "y" (str.++ "\u{1f}" ""))))))))))))))))
;witness2: "PhARmaCy"
(define-fun Witness2 () String (str.++ "P" (str.++ "h" (str.++ "A" (str.++ "R" (str.++ "m" (str.++ "a" (str.++ "C" (str.++ "y" "")))))))))

(assert (= regexA (re.union (str.to_re (str.++ "p" (str.++ "h" (str.++ "a" (str.++ "r" (str.++ "m" (str.++ "a" (str.++ "c" (str.++ "y" ""))))))))) (re.++ (re.range "p" "p")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "h" "h")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "a" "a")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "r" "r")(re.++ (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "{" (str.++ "1" (str.++ "," (str.++ "3" "")))))))(re.++ (re.range "m" "m")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "a" "a")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.range "c" "c")(re.++ (re.opt ((_ re.loop 1 3) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (re.range "y" "y"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
