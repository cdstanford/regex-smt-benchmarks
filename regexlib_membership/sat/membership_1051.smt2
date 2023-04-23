;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.*\.jpe?g|.*\.JPE?G)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "w.JPEG\xB"
(define-fun Witness1 () String (str.++ "w" (str.++ "." (str.++ "J" (str.++ "P" (str.++ "E" (str.++ "G" (str.++ "\u{0b}" ""))))))))
;witness2: "\u00AA.JPEG\u00B2\u00F2"
(define-fun Witness2 () String (str.++ "\u{aa}" (str.++ "." (str.++ "J" (str.++ "P" (str.++ "E" (str.++ "G" (str.++ "\u{b2}" (str.++ "\u{f2}" "")))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "." (str.++ "j" (str.++ "p" ""))))(re.++ (re.opt (re.range "e" "e")) (re.range "g" "g")))) (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "." (str.++ "J" (str.++ "P" ""))))(re.++ (re.opt (re.range "E" "E")) (re.range "G" "G")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
