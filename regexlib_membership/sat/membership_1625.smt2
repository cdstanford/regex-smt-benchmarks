;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[a-zA-Z]+(\s+[a-zA-Z]+\s*=\s*("([^"]*)"|'([^']*)'))*\s*/>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AE<L\u0085\u00A0/>\u00E1"
(define-fun Witness1 () String (str.++ "\u{ae}" (str.++ "<" (str.++ "L" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "/" (str.++ ">" (str.++ "\u{e1}" "")))))))))
;witness2: "<zNz\u00A0Y\u00A0=\'\'\x9\x9I\u0085=\'\'\u00A0 />"
(define-fun Witness2 () String (str.++ "<" (str.++ "z" (str.++ "N" (str.++ "z" (str.++ "\u{a0}" (str.++ "Y" (str.++ "\u{a0}" (str.++ "=" (str.++ "'" (str.++ "'" (str.++ "\u{09}" (str.++ "\u{09}" (str.++ "I" (str.++ "\u{85}" (str.++ "=" (str.++ "'" (str.++ "'" (str.++ "\u{a0}" (str.++ " " (str.++ "/" (str.++ ">" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "/" (str.++ ">" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
