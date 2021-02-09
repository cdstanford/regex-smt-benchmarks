;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[a-zA-Z]+(\s+[a-zA-Z]+\s*=\s*("([^"]*)"|'([^']*)'))*\s*/>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AE<L\u0085\u00A0/>\u00E1"
(define-fun Witness1 () String (seq.++ "\xae" (seq.++ "<" (seq.++ "L" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "/" (seq.++ ">" (seq.++ "\xe1" "")))))))))
;witness2: "<zNz\u00A0Y\u00A0=\'\'\x9\x9I\u0085=\'\'\u00A0 />"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "z" (seq.++ "N" (seq.++ "z" (seq.++ "\xa0" (seq.++ "Y" (seq.++ "\xa0" (seq.++ "=" (seq.++ "'" (seq.++ "'" (seq.++ "\x09" (seq.++ "\x09" (seq.++ "I" (seq.++ "\x85" (seq.++ "=" (seq.++ "'" (seq.++ "'" (seq.++ "\xa0" (seq.++ " " (seq.++ "/" (seq.++ ">" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re (seq.++ "/" (seq.++ ">" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
