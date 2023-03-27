;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<\!\-\-(.*)+(\/){0,1}\-\->$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<!--Z.-\x7\u00E3-->"
(define-fun Witness1 () String (str.++ "<" (str.++ "!" (str.++ "-" (str.++ "-" (str.++ "Z" (str.++ "." (str.++ "-" (str.++ "\u{07}" (str.++ "\u{e3}" (str.++ "-" (str.++ "-" (str.++ ">" "")))))))))))))
;witness2: "<!--/-->"
(define-fun Witness2 () String (str.++ "<" (str.++ "!" (str.++ "-" (str.++ "-" (str.++ "/" (str.++ "-" (str.++ "-" (str.++ ">" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "<" (str.++ "!" (str.++ "-" (str.++ "-" "")))))(re.++ (re.+ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.opt (re.range "/" "/"))(re.++ (str.to_re (str.++ "-" (str.++ "-" (str.++ ">" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
