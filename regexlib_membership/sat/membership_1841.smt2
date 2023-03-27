;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z]:(\\w+)*\\[a-zA-Z0_9]+)?.xls
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "v:\0\u00F9xls\xE"
(define-fun Witness1 () String (str.++ "v" (str.++ ":" (str.++ "\u{5c}" (str.++ "0" (str.++ "\u{f9}" (str.++ "x" (str.++ "l" (str.++ "s" (str.++ "\u{0e}" ""))))))))))
;witness2: "\u0091xls"
(define-fun Witness2 () String (str.++ "\u{91}" (str.++ "x" (str.++ "l" (str.++ "s" "")))))

(assert (= regexA (re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range ":" ":")(re.++ (re.* (re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.range "w" "w"))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.union (re.range "0" "0")(re.union (re.range "9" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "x" (str.++ "l" (str.++ "s" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
