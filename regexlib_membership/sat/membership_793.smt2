;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\/?(tag1|tag2)[^>]*\/?>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x19<tag2O\u00A0\'/>"
(define-fun Witness1 () String (str.++ "\u{19}" (str.++ "<" (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "2" (str.++ "O" (str.++ "\u{a0}" (str.++ "'" (str.++ "/" (str.++ ">" ""))))))))))))
;witness2: "<tag1>j\u00A8\u00E5\u00A87`"
(define-fun Witness2 () String (str.++ "<" (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "1" (str.++ ">" (str.++ "j" (str.++ "\u{a8}" (str.++ "\u{e5}" (str.++ "\u{a8}" (str.++ "7" (str.++ "`" "")))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.union (str.to_re (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "1" ""))))) (str.to_re (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "2" ""))))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.opt (re.range "/" "/")) (re.range ">" ">"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
