;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\\/\/(?:www.)?clipser\.com\/watch_video\/([0-9a-z-_]+)/i'
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\'/http:\//www2clipser.com/watch_video/z_-/i\'#I"
(define-fun Witness1 () String (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "2" (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "_" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "/" (seq.++ "z" (seq.++ "_" (seq.++ "-" (seq.++ "/" (seq.++ "i" (seq.++ "'" (seq.++ "#" (seq.++ "I" "")))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00AD\'/http:\//clipser.com/watch_video/r/i\'#"
(define-fun Witness2 () String (seq.++ "\xad" (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "_" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "/" (seq.++ "r" (seq.++ "/" (seq.++ "i" (seq.++ "'" (seq.++ "#" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "\x5c" (seq.++ "/" (seq.++ "/" "")))))))))))(re.++ (re.opt (re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "_" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "/" "")))))))))))))))))))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))) (str.to_re (seq.++ "/" (seq.++ "i" (seq.++ "'" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
