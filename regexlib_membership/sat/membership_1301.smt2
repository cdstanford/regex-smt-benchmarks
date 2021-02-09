;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [URL=[a-zA-Z0-9.:/_\-]+\][a-zA-Z0-9._/ ]+\[/URL\]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F4.] [/URL]"
(define-fun Witness1 () String (seq.++ "\xf4" (seq.++ "." (seq.++ "]" (seq.++ " " (seq.++ "[" (seq.++ "/" (seq.++ "U" (seq.++ "R" (seq.++ "L" (seq.++ "]" "")))))))))))
;witness2: "\x1Ex-]1K[/URL]\u00DBj"
(define-fun Witness2 () String (seq.++ "\x1e" (seq.++ "x" (seq.++ "-" (seq.++ "]" (seq.++ "1" (seq.++ "K" (seq.++ "[" (seq.++ "/" (seq.++ "U" (seq.++ "R" (seq.++ "L" (seq.++ "]" (seq.++ "\xdb" (seq.++ "j" "")))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" ":")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "]" "]")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (str.to_re (seq.++ "[" (seq.++ "/" (seq.++ "U" (seq.++ "R" (seq.++ "L" (seq.++ "]" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
