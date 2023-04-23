;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [URL=[a-zA-Z0-9.:/_\-]+\][a-zA-Z0-9._/ ]+\[/URL\]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F4.] [/URL]"
(define-fun Witness1 () String (str.++ "\u{f4}" (str.++ "." (str.++ "]" (str.++ " " (str.++ "[" (str.++ "/" (str.++ "U" (str.++ "R" (str.++ "L" (str.++ "]" "")))))))))))
;witness2: "\x1Ex-]1K[/URL]\u00DBj"
(define-fun Witness2 () String (str.++ "\u{1e}" (str.++ "x" (str.++ "-" (str.++ "]" (str.++ "1" (str.++ "K" (str.++ "[" (str.++ "/" (str.++ "U" (str.++ "R" (str.++ "L" (str.++ "]" (str.++ "\u{db}" (str.++ "j" "")))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ":")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "]" "]")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (str.to_re (str.++ "[" (str.++ "/" (str.++ "U" (str.++ "R" (str.++ "L" (str.++ "]" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
