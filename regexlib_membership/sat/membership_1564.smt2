;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<http>(http:[/][/]|www.)([a-z]|[A-Z]|[0-9]|[/.]|[~])*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "www\u00ADh"
(define-fun Witness1 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{ad}" (str.++ "h" ""))))))
;witness2: "http:///jw"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "/" (str.++ "j" (str.++ "w" "")))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))) (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (re.* (re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "~" "~"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
